class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :display_name
  has_many :posts, dependent: :destroy
  has_many :text_posts
  has_many :link_posts
  has_many :image_posts

  validates :email, :format => {
      :message => "must be in the form a@b.com",
      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/

    }

  validates :display_name, :presence => true, 
                         :format => { 
                           :message => "Must only be letters, numbers, underscore or dashes", 
                           :with => /^[a-zA-Z0-9_-]+$/ 
                         },
                         :uniqueness => true

  def relation_for(type)
    self.send(type.underscore.pluralize.to_sym).scoped rescue text_posts.scoped
  end
  
  def send_welcome_message
    UserMailer.welcome_message(self).deliver
  end
end
