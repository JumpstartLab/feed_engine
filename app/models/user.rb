# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)
#  password_digest        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  display_name           :string(255)
#  api_key                :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

# Users of the site
class User < ActiveRecord::Base
  after_create :generate_api_key

  has_secure_password

  has_many :messages, :foreign_key => 'poster_id'
  has_many :images, :foreign_key => 'poster_id'
  has_many :links, :foreign_key => 'poster_id'
  has_many :subscriptions
  has_many :tweets, :through => :subscriptions, :foreign_key => 'poster_id'
  has_many :items, :foreign_key => 'poster_id'

  default_scope order(:created_at)

  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :display_name,
                  :api_key

  validates :email, :uniqueness => true
  validates_presence_of :email, :message => "is required"
  validates :password, :length => { :minimum => 6 }
  validates_format_of :email,
    :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,
    :allow_blank => true
  validates :display_name,
    :presence => true,
    :format => {
      :with => /^[a-zA-Z\d\-]*$/,
      :message => "must contain only letters, numbers or dashes"
    },
    :exclusion => { :in => %w(www api nil) },
    :uniqueness => true

  SERVICES_LIST =  %w(twitter github instagram)

  def send_welcome_email
    UserMailer.signup_notification(self).deliver
  end

  def posts
    items.map(&:post)
  end

  def sorted_posts
    posts.sort_by(&:created_at).reverse
  end

  def items
    Item.find_all_by_poster_id(id)
  end

  def subdomain
    display_name
  end

  def disconnected_services
    SERVICES_LIST - subscriptions.map(&:provider).uniq
  end

  def post_page_count
    (posts.length.to_f / 12).ceil
  end

  def send_password_reset
    generate_password_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  private

  def generate_password_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def generate_api_key
    key = Digest::MD5.hexdigest(
      'Elise punches puppies' +
      Time.at(Time.now).nsec.to_s +
      self.email +
      rand(424242424242424242).to_s
    )
    self.update_attributes api_key: key
  end
end
