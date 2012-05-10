class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :display_name
  validates :email, :uniqueness => true, :presence => true
  validates_presence_of :password, :message => "Password can't be blank"
  validates :password, :length => { :minimum => 6 }
  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
  validates_format_of :display_name, :with => /^[a-zA-Z\d\-_]*$/,
    :message => "Display name must be only letters,
    numbers, dashes, or underscores"


  def send_welcome_email
    UserMailer.signup_notification(self).deliver
  end

  validates :email, :uniqueness => true

end
