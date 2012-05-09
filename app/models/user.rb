class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :display_name
  validates :email, :uniqueness => true, :presence => true
end
