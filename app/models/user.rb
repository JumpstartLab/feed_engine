require 'securerandom'
class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_create :set_user_subdomain
  after_create :create_user_feed
  after_create :generate_authentication_token
  after_create :send_welcome_email

  attr_accessible :email, :password, :password_confirmation, :display_name, :subdomain
  has_many :authentications
  has_many :tweets
  has_many :githubevents
  has_many :posts
  has_one :feed
  validates_presence_of :email
  validates :password, presence: true, length: {minimum: 6}
  validates_confirmation_of :password, :on => :create, :message => "should match confirmation"



  DISPLAY_NAME_REGEX = /^[\w-]*$/
  validates :display_name, 
    format: { with: DISPLAY_NAME_REGEX, message: "must be only letters, numbers, dashes, or underscores" },
    presence: true, 
    uniqueness: true,
    exclusion: { in: %w(www ftp api), message: "can not be www, ftp, or api" }

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def set_user_subdomain
    self.subdomain = self.display_name.downcase
  end

  def create_user_feed
    Feed.create(:user_id => self.id, :name => self.subdomain)
  end

  FEED_TYPES.each do |type_name|
    has_many type_name.to_s.to_sym
  end
  
  def posts
    FEED_TYPES.map do |association|
      self.send(association.to_s.to_sym).all
    end.flatten.uniq.compact.sort_by { |post| post.created_at }
  end
  
  def generate_authentication_token
    token = Digest::SHA256.hexdigest("#{SecureRandom.hex(15)}HuNgRyF33d#{Time.now}")
    token = generate_authentication_token if User.exists?(authentication_token: token)
    self.update_attribute(:authentication_token, token)
  end

  def update_password(params)
    current_password = params[:current_password]
    new_password = params[:new_password]
    new_password_confirmation = params[:password_confirmation]
    if User.authenticate(self.email, current_password).present?
      if new_password == new_password_confirmation
        self.update_attribute(:password, new_password)
      else
        self.errors.add :password_confirmation, "does not match new password"
      end
    else
      self.errors.add :password, "incorrect"
    end
  end

  def twitter_id
    authentications.find_by_provider('twitter').uid
  end

  def github_handle
    authentications.find_by_provider('github').handle
  end

  def instagram_id
    authentications.find_by_provider('instagram').uid
  end

  def instagram_token
    authentications.find_by_provider('instagram').token
  end
end