class User < ActiveRecord::Base
  after_create :send_welcome_email
  devise :database_authenticatable, :recoverable, :validatable
  attr_accessible :email, :password, :password_confirmation, :display_name

  DISPLAY_NAME_REGEX = /^[\w-]*$/
  validates :display_name, format: { with: DISPLAY_NAME_REGEX, message: "must be only letters, numbers, dashes, or underscores" }, presence: true
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
  
  def posts
    posts = []
    TYPES.each do |klass|
      posts += klass.find_all_by_user_id(id.to_s)
    end
    posts
  end
end
