class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :display_name, :password, :password_confirmation, :remember_me
  validates :display_name, :presence => true
  validates :display_name, :format => { :with => /\A[a-zA-Z0-9_-]+\z/, 
            :message => "may only contain letters, numbers, dashes, and underscores." }  

  after_create :send_welcome_mail
  before_save :ensure_authentication_token

  has_many :text_items
  has_many :image_items
  has_many :link_items
  has_many :stream_items, :includes => :streamable

  def add_stream_item(item)
    stream_items << StreamItem.new(:streamable_id => item.id,
                                   :streamable_type => item.class.name)
  end

  def new_stream_item_from_json(parsed_json)
    case parsed_json["type"]
    when "TextItem"
      new_text_item_from_json(parsed_json)
    when "LinkItem"
      new_link_item_from_json(parsed_json)
    when "ImageItem"
      new_image_item_from_json(parsed_json)
    end

  end

  private

  def new_text_item_from_json(parsed_json)
    text_items.new(:body => parsed_json["body"])
  end

  def new_image_item_from_json(parsed_json)
    image_items.new(:url => parsed_json["image_url"], :comment => parsed_json["comment"])
  end

  def new_link_item_from_json(parsed_json)
    link_items.new(:url => parsed_json["link_url"], :comment => parsed_json["comment"])
  end

  def send_welcome_mail
    Resque.enqueue(WelcomeMailJob, self)
  end
end
