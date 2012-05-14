require 'securerandom'
class User < ActiveRecord::Base
  before_create :set_user_subdomain
  before_create :generate_api_key
  after_create :send_welcome_email
  devise :database_authenticatable, :recoverable, :validatable
  attr_accessible :email, :password, :password_confirmation, :display_name, :subdomain

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

  TYPES.each do |type_name|
    has_many type_name.to_s.to_sym
  end
  
  def posts
    TYPES.map do |association|
      self.send(association.to_s.to_sym).all
    end.flatten.uniq.compact.sort_by { |post| post.created_at }
  end

  def generate_api_key
    key = Digest::SHA256.hexdigest("#{SecureRandom.hex(15)}HuNgRyF33d#{Time.now}")
    key = generate_api_key if User.exists?(api_key: key)
    self.update_attribute(:api_key, key)
  end
end