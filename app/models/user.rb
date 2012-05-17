class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  before_save :ensure_authentication_token
  validates_uniqueness_of :display_name, :case_sensitive => false
  validates_format_of :display_name, :with => /^[A-Za-z\d]+$/, message:
            "Required. Display name must only be letters, numbers, or dashes"

  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :display_name

  has_many :authentications, :dependent => :destroy
  has_one :twitter_account, :through => :authentications

  has_many :growls, :dependent => :destroy
  has_many :images
  has_many :messages
  has_many :links
  has_many :tweets

  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions
  has_many :inverse_subscriptions, :class_name => "Subscription", :foreign_key => "subscriber_id"
  has_many :inverse_subscribers, :through => :inverse_subscriptions, :source => :user

  has_one :twitter_account, :through => :authentications
  has_one :github_account, :through => :authentications
  has_many :github_events

  has_many :regrowls

  def relation_for(type)
    self.send(type.downcase.pluralize.to_sym).scoped rescue messages.scoped
  end

  def github_client
    return nil unless github_oauth = authentications.where(provider: "github").first

    Github::Client.new( :consumer_key => GITHUB_KEY,
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

  def has_tweets?
    tweets.size > 0
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

<<<<<<< HEAD
=======
  def twitter_account
    twitter.twitter_account
  end

>>>>>>> 970a4cc6f1ee746c1ba16702eb07145e99edfc1a
  def github
    authentications.github
  end

  def github?
    authentications.github?
  end

  def github_account
    github.github_account
  end

  def can_regrowl?(original_growl)
<<<<<<< HEAD
    growls.where(regrowled_from_id: original_growl.id).empty?
  end

  def slug
    display_name.downcase
=======
    growls.where(regrowled_from_id: original_growl.id).empty? && original_growl.user_id != id
>>>>>>> 970a4cc6f1ee746c1ba16702eb07145e99edfc1a
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer         primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :timestamp
#  remember_created_at    :timestamp
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :timestamp
#  last_sign_in_at        :timestamp
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :timestamp       not null
#  updated_at             :timestamp       not null
#  display_name           :string(255)
#  authentication_token   :string(255)
#  private                :boolean         default(FALSE)
#

