require 'securerandom'
class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_create :set_user_subdomain
  after_create :create_user_feed
  after_create :generate_authentication_token
  after_create :send_welcome_email

  attr_accessible :email, :password, :password_confirmation,
                  :display_name, :subdomain
  has_many :authentications
  has_many :tweets
  has_many :githubevents
  has_many :posts
  has_many :subscriptions
  has_many :points
  has_one :feed

  validates :email, uniqueness: true, presence: true
  validates :password,
    presence: true,
    confirmation: true,
    length: {minimum: 6, :message => "must be at least 6 characters long"}

  DISPLAY_NAME_REGEX = /^[a-zA-Z0-9\-_]*$/
  validates :display_name,
    format: {with: DISPLAY_NAME_REGEX,
             message: "only letters, numbers, or dashes" },
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
    find_sub_feed = self.subscriptions.find_by_feed_id(sub_feed.id)
    unless (self.feed.id == sub_feed.id) || find_sub_feed
      self.subscriptions.create(:feed_id => sub_feed.id)
    end
  end

  def create_user_feed
    Feed.create(:user_id => self.id, :name => self.subdomain)
  end

  FEED_TYPES.each do |type_name|
    has_many type_name.to_s.to_sym
  end

  def reset_password
    self.update_attribute(:password,
      Digest::SHA512.hexdigest(
        Digest::SHA384.hexdigest(
          Digest::SHA256.hexdigest(
      "#{self.email}HuNgRyF33d#{FeedEngine::Application.config.secret_token}"
          ))))
    send_reset_email
  end

  def send_reset_email
    UserMailer.reset_password_email(self).deliver
  end

  def posts
    FEED_TYPES.map do |association|
      self.send(association.to_s.to_sym).all
    end.flatten.uniq.compact.sort_by { |post| post.created_at }
  end

  def generate_authentication_token
    token = Digest::SHA256.hexdigest("#{SecureRandom.hex(15)}HuN3d#{Time.now}")
    if User.exists?(authentication_token: token)
      token = generate_authentication_token
    end
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