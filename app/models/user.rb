class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :display_name, :password, :password_confirmation, :remember_me

  validates :display_name, :presence => true
  validates :display_name, :length => { :maximum => 20 }
  validates_uniqueness_of :display_name, :case_sensitive => false
  validates :display_name, :format => { :with => /\A[a-zA-Z0-9_-]+\z/,
            :message => "may only contain letters, numbers, dashes, and underscores." }

  after_create :send_welcome_mail
  before_save :ensure_authentication_token

  has_many :text_items
  has_many :image_items
  has_many :link_items
  has_many :twitter_items
  has_many :github_items
  has_many :instagram_items
  has_many :stream_items
  has_many :authentications
  has_many :subscriptions, :foreign_key => :follower_id
  has_many :followed_users, :through => :subscriptions, :source => :followed_user
  #has_many :followers, :through => :subscriptions, :source => :follower

  def add_stream_item(item, refeed=true)
    stream_items << StreamItem.new(:streamable_id => item.id,
                                   :streamable_type => item.class.name,
                                   :original_author_id => item.user.id,
                                   :refeed => refeed)
  end

  def last_retrout_id_for_user(followed_user)
    items = stream_items.where(:streamable_type => ["ImageItem","LinkItem","TextItem"]).where(:original_author_id => followed_user.id)
    if items.any?
      items.last.id
    else
      1
    end
  end

  def to_param
    display_name
  end

  def last_twitter_item
    twitter_items.order("tweet_time DESC").first
  end

  def can_retrout?(original_item)
    original_item.user_id != id && !has_retrouts_for?(original_item)
  end

  def has_retrouts_for?(item)
    stream_items.where(:refeed => true).where(:streamable_type => item.class).where(:streamable_id => item.id).where(:refeed => true).any?
  end

  def follower_count
    Subscription.find_all_by_followed_user_id(self.id).count
  end

  def self.new_spawns
    User.last(6)
  end 

  private

  def send_welcome_mail
    Resque.enqueue(WelcomeMailJob, self)
  end
end
