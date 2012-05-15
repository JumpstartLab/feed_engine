class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  before_save :ensure_authentication_token
  validates_uniqueness_of :display_name
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

  def twitter_account
    authentications.twitter.twitter_account if authentications.twitter
  end

  def relation_for(type)
    self.send(type.downcase.pluralize.to_sym).scoped rescue messages.scoped
  end

  def github_client
    return nil unless github_oauth = authentications.where(provider: "github").first

    Github::Client.new(:consumer_key => GITHUB_KEY,
                        :consumer_secret => GITHUB_SECRET,
                        :oauth_token => github_oauth.token,
                        :oauth_token_secret => github_oauth.secret)
  end

  def send_welcome_message
    mail = UserMailer.welcome_message(email).deliver
  end

  def self.find_twitter_users
    includes(:authentications).where("authentications.provider" => "twitter")
  end

  def get_growls(type=nil)
    growls.by_type_and_date(type)
  end

  def last_twitter_id
    self.tweets.order(:external_id).last.external_id if self.tweets.size > 0
  end

  def avatar
    require 'digest/md5'
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end

  def api_link(request)
    "http://api.#{request.domain}/feeds/#{display_name}"
  end

  def web_url(request)
    "http://#{display_name}.#{request.domain}"
  end

  def twitter
    authentications.twitter
  end

  def twitter?
    authentications.twitter?
  end


  def github?
    authentications.github?
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

