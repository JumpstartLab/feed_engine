class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :display_name

  validates :email, :uniqueness => true

  #def posts
   #it collects the links, images, and messages associated with user 
   
   #def sorted_posts
   # sorted_posts = posts.sort_by { |p| p.created_at.reverse }
end
