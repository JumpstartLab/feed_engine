class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :display_name

  validates :display_name, :presence => true, 
                           :format => { 
                             :message => "Spaces are not allowed", 
                             :with => /^\S*$/ 
                           },
                           :uniqueness => true

  # attr_accessible :title, :body
  
  def send_welcome_message
    UserMailer.welcome_message(self).deliver
  end
end
