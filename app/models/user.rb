class User < ActiveRecord::Base
  after_create :send_welcome_email
  devise :database_authenticatable, :recoverable, :validatable
  attr_accessible :email, :password, :password_confirmation, :display_name

  DISPLAY_NAME_REGEX = /^[\w-]*$/
  validates :display_name, 
    format: { with: DISPLAY_NAME_REGEX, message: "must be only letters, numbers, dashes, or underscores" },
    presence: true, 
    uniqueness: true,
    exclusion: { in: %w(www ftp), message: "can not be www or ftp" }
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def posts
    TYPES.inject([]) do |posts, klass|
      posts += klass.scoped.where("user_id = ?", self.id)
    end.uniq.compact.sort_by { |post| post.created_at }
  end
end