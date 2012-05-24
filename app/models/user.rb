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
#  private                :boolean         default(FALSE)
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#

require 'digest/md5'

class User < ActiveRecord::Base

  has_many :text_posts,      through: :posts, source: :postable, source_type: 'TextPost'
  has_many :image_posts,     through: :posts, source: :postable, source_type: 'ImagePost'
  has_many :link_posts,      through: :posts, source: :postable, source_type: 'LinkPost'
  has_many :twitter_posts,   through: :posts, source: :postable, source_type: 'TwitterPost'
  has_many :github_posts,    through: :posts, source: :postable, source_type: 'GithubPost'
  has_many :instagram_posts, through: :posts, source: :postable, source_type: 'InstagramPost'

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :posts, dependent: :destroy, :extend => PageExtension

  has_many :authentications
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :token_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :display_name, :full_name, :login, :private
  attr_accessor :login

  validates_presence_of :display_name, :case_sensitive => false
  validates_uniqueness_of :display_name
  validates_format_of :display_name, :with => /^[^ ]+$/

  before_save :ensure_authentication_token

  after_create :send_welcome_email

  def gravatar_url
    @gravatar_url ||= "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}?d=mm&size=90"
  end

  def send_welcome_email
    UserMailer.delay.welcome_email(self)
  end

  def send_reset_password_instructions
    Devise::Mailer.delay.reset_password_instructions(self)
  end

  def post_of(kind)
    send(kind.tableize.to_sym)
  end

  def to_param
    display_name
  end

  def providers
    authentications.map { |a| a.provider }
  end

  def provider_added?(provider)
    providers.include?(provider)
  end

  def auth_for(provider)
    authentications.where(provider: provider).first
  end

  def remove_auth_for(provider)
    authentications.destroy(auth_for(provider))
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(display_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def following?(other_user)
    self.followed_user_ids.include?(other_user.id)
  end

  def follow(other_user)
    if other_user.last_post.blank?
      self.relationships.create!(followed_id: other_user.id,
                                 last_post_id: nil)
    else
      self.relationships.create!(followed_id: other_user.id,
                                 last_post_id: other_user.last_post.id)
    end
  end

  def unfollow(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end

  def last_post
    self.posts.last
  end

  def refeeded_posts
    self.posts.select { |post| post.refeed? }
  end

  def last_instagram_id
    last_post = instagram_posts.order("instagram_id DESC").first
    last_post && last_post.instagram_id
  end

  def last_github_id
    unless
      auth_for("github").last_status_id
    else
      auth_for("github").last_status_id
      # last_post = github_posts.order("github_id DESC").first
      # last_post && last_post.github_id  
    end
  end

  def last_twitter_id
    unless twitter_posts.any?
      auth_for("twitter").last_status_id
    else
      last_post = twitter_posts.order("twitter_id DESC").first
      last_post && last_post.twitter_id
    end
  end

  def total_points
    total = 0
    self.posts.each do |post|
      total += post.points.size
    end
    total
  end

end
