class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :token_authenticatable

  before_save :ensure_authentication_token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :display_name
  has_many :posts, dependent: :destroy
  has_many :text_posts
  has_many :link_posts
  has_many :image_posts
  has_many :authentications

  validates :email, :format => {
      :message => "must be in the form a@b.com",
      :with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/

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

  def total_pages
    self.posts.size() / 12 + 1
  end

  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'twitter'
      self.apply_twitter(omniauth)
    end
    a = authentications.build(hash_from_omniauth(omniauth))
    a.inspect
  end

  def twitter
    unless @twitter_user
      provider = self.authentications.find_by_provider('twitter')
      @twitter_user = Twitter::Client.new(:oauth_token => provider.token, :oauth_token_secret => provider.secret) rescue nil
    end
    @twitter_user
  end

  private

  def apply_twitter(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      # Example fetching extra data. Needs migration to User model:
      # self.firstname = (extra['name'] rescue '')
    end
  end

  def hash_from_omniauth(omniauth)
    {
      :provider => omniauth['provider'], 
      :uid => omniauth['uid'], 
      :token => (omniauth['credentials']['token'] rescue nil),
      :secret => (omniauth['credentials']['secret'] rescue nil)
    }
  end
end
