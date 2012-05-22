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
  has_many :subscriptions
  has_one :feed
  validates_presence_of :email
  validates :password, presence: true, length: {minimum: 6}
  validates_confirmation_of :password, :on => :create, :message => "should match confirmation"

  DISPLAY_NAME_REGEX = /^[a-zA-Z0-9\-]*$/
  validates :display_name, 
    format: { with: DISPLAY_NAME_REGEX, message: "must be only letters, numbers, or dashes" }, 
    uniqueness: true

  BAD_DISPLAY_NAMES = ['ftp', 'api', 'null', 'www']
  validate :display_name_is_not_bad
  
  validates :subdomain, uniqueness: true
  
  def display_name_is_not_bad
    if display_name.nil? || display_name.blank?
      errors.add(:display_name, "can not be blank")
    elsif BAD_DISPLAY_NAMES.include?(display_name.downcase)
      errors.add(:display_name, "can not be www, ftp, api, or null")
    elsif display_name =~ /^[\-]/
      errors.add(:display_name, "can not start with a dash")
    end
  end
    
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def set_user_subdomain
    self.subdomain = self.display_name.gsub("_","-").downcase
  end

  def subscribe(feed_name)
    sub_feed = Feed.find_by_name(feed_name)
    unless (self.feed.id == sub_feed.id) || (self.subscriptions.find_by_feed_id(sub_feed.id))
      self.subscriptions.create(:feed_id => sub_feed.id)
    end
  end

  # Commenting out for now - implemented in the event that we want users to be able to set their subdomain and feed name at will
  # def set_user_feed_name
  #   self.feed.set_name(self.subdomain)
  # end

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