# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  password_salt          :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  display_name           :string(255)
#  full_name              :string(255)
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :token_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :display_name

  validates_presence_of :display_name
  validates_uniqueness_of :display_name
  validates_format_of :display_name, :with => /^[^ ]+$/

  before_save :ensure_authentication_token

  after_create :send_welcome_email

  has_many :text_posts, through: :posts, source: :postable, source_type: 'TextPost' 
  has_many :image_posts, through: :posts, source: :postable, source_type: 'ImagePost'
  has_many :link_posts, through: :posts, source: :postable, source_type: 'LinkPost'

  # has_many :text_posts, through: :posts, source: :feed, source_type: 'TextPost'
  # has_many :image_posts, through: :posts, source: :feed, source_type: 'ImagePost'
  # has_many :link_posts, through: :posts, source: :feed, source_type: 'LinkPost'
  has_many :posts

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def self.stream
    stream = []
    link_posts = LinkPost.all
    image_posts = ImagePost.all
    text_posts = TextPost.all
    stream << [link_posts, image_posts, text_posts]
    stream.flatten
  end

  def self.order_stream
    stream.sort_by {|content| content.created_at}.reverse
  end

end
