class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :validatable
  attr_accessible :email, :password, :password_confirmation, :display_name
  has_many :posts

end
