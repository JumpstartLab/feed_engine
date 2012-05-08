class User < ActiveRecord::Base
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :display_name
  # attr_accessible :title, :body
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
