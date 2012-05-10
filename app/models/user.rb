class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  before_save :ensure_authentication_token
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^[A-Za-z\d_]+$/, message:
            "Display name must only be letters, numbers, dashes, or underscores"

  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :username
  
  has_many :authentications, :dependent => :destroy
  has_many :growls
  has_many :images
  has_many :messages
  has_many :links

  def twitter_client
    return nil unless twitter_oauth = authentications.where(provider: "twitter").first

    # XXX what if they have multiple twitters?
    Twitter::Client.new(:consumer_key => TWITTER_KEY,
                        :consumer_secret => TWITTER_SECRET,
                        :oauth_token => twitter_oauth.token,
                        :oauth_token_secret => twitter_oauth.secret)
  end

  def send_welcome_message
    mail = UserMailer.welcome_message(self)
    mail.deliver
  end
end
