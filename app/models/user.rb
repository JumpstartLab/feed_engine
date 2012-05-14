class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  before_save :ensure_authentication_token
  validates_uniqueness_of :display_name
  validates_format_of :display_name, :with => /^[A-Za-z\d]+$/, message:
            "Required. Display name must only be letters, numbers, or dashes"

  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :display_name

  has_many :authentications, :dependent => :destroy
  has_many :growls, :dependent => :destroy
  has_many :images
  has_many :messages
  has_many :links
  has_many :tweets

  def relation_for(type)
    self.send(type.downcase.pluralize.to_sym).scoped rescue messages.scoped
  end

  def github_client
    return nil unless github_oauth = authentications.where(provider: "github").first

    Github::Client.new(:consumer_key => GITHUB_KEY,
                        :consumer_secret => GITHUB_SECRET,
                        :oauth_token => github_oauth.token,
                        :oauth_token_secret => github_oauth.secret)
  end

  def send_welcome_message
    mail = UserMailer.welcome_message(self)
    mail.deliver
  end

  def get_growls(type=nil)
    growls.by_type_and_date(type)
  end

 def get_tweets()
    since = since_last_checked
    if since
      twitter_client.user_timeline({:since_id => since})
    else
      twitter_client.user_timeline()
    end
  end

  def store_tweets
    get_tweets.each do |tweet|
        Tweet.create(
                     comment: tweet.text,
                     link: tweet.source,
                     external_id: tweet.id,
                     created_at: tweet.created_at, # Not sure if this will work...
                     user_id: self.id
                    )
    end
  end

  def since_last_checked
    self.tweets.order(:external_id).last.external_id if self.tweets.size > 0
  end

  def avatar
    require 'digest/md5'
     "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end

  def api_link(request)
    "http://api.#{request.domain}/feeds/#{display_name}"
  end

  def web_url(request)
    "http://#{display_name}.#{request.domain}"
  end

  def twitter_client
    return nil unless twitter_oauth = self.authentications.twitter

    Twitter::Client.new(:consumer_key => TWITTER_KEY,
                        :consumer_secret => TWITTER_SECRET,
                        :oauth_token => twitter_oauth.token,
                        :oauth_token_secret => twitter_oauth.secret)
  end

end

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
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  display_name           :string(255)
#  authentication_token   :string(255)
#  private                :boolean         default(FALSE)
#

