class User < ActiveRecord::Base
  after_create :send_welcome_email
  devise :database_authenticatable, :recoverable, :validatable
  attr_accessible :email, :password, :password_confirmation, :display_name
  has_many :posts
  
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
