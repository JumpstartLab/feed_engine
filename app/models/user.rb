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
  
  has_many :authentications
  has_many :growls
  has_many :images
  has_many :messages
  has_many :links

  def send_welcome_message
    UserMailer.welcome_message(self).deliver
  end

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_email(data.email)
      user
    else # Create a user with a stub password. 
      self.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
    end
  end

end
