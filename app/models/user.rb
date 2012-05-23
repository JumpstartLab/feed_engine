class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  before_save :ensure_authentication_token

  validates_uniqueness_of :display_name, :case_sensitive => false
  validates_length_of :display_name, :minimum => 4
  validates_format_of :display_name, :with => /^[A-Za-z\d]+$/, message:
            "Required. Display name must only be letters, numbers, or dashes"

  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :display_name

  has_many :authentications, :dependent => :destroy

  has_many :growls, :dependent => :destroy
  has_many :images
  has_many :messages
  has_many :links
  has_many :tweets
  has_many :instagram_photos
  has_many :github_events

  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions
  has_many :inverse_subscriptions, :class_name => "Subscription", :foreign_key => "subscriber_id"
  has_many :inverse_subscribers, :through => :inverse_subscriptions, :source => :user

  def relation_for(type)
    self.send(type.downcase.pluralize.to_sym).scoped rescue messages.scoped
  end

  # def github_client
  #   return nil unless github_oauth = authentications.where(provider: "github").first

  #   Github::Client.new( :consumer_key => GITHUB_KEY,
  #                       :consumer_secret => GITHUB_SECRET,
  #                       :oauth_token => github_oauth.token,
  #                       :oauth_token_secret => github_oauth.secret)
  # end

  def twitter_client
    return nil unless twitter_oauth = twitter

    Twitter::Client.new(:consumer_key => TWITTER_KEY,
                        :consumer_secret => TWITTER_SECRET,
                        :oauth_token => twitter_oauth.token,
                        :oauth_token_secret => twitter_oauth.secret)
  end


  def send_welcome_message
    mail = UserMailer.welcome_message(email).deliver
  end

  # def self.find_twitter_users
  #   includes(:authentications).where("authentications.provider" => "twitter")
  # end

  def get_growls(type=nil)
    growls.by_type_and_date(type)
  end

  def subscribed_to?(user)
    inverse_subscriptions.where(user_id: user.id).size > 0
  end

  def not_subscribed_to?(user)
    !subscribed_to?(user)
  end

  def avatar
    require 'digest/md5'
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end

  def api_link(request)
    "http://api.#{request.domain}/v1/feeds/#{slug}"
  end

  def web_url(request)
    "http://#{slug}.#{request.domain}"
  end

  Authentication::SERVICES.each do |service|
    define_method "#{service}".to_sym do
      authentications.send("#{service}".to_sym)
    end

    define_method "#{service}?".to_sym do
      authentications.send("#{service}?".to_sym)
    end

    define_method "#{service}_account".to_sym do
      send(service.to_sym).send("#{service}_account".to_sym)
    end
  end

  def can_regrowl?(original_growl)
    original_growl.user_id != id && growls.where(regrowled_from_id: original_growl.id).empty?
  end

  def slug
    display_name.downcase
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  display_name           :string(255)
#  authentication_token   :string(255)
#  private                :boolean         default(FALSE)
#

