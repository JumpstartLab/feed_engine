# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer         not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  user_name  :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# The model for any external subscriptions
class Subscription < ActiveRecord::Base
  EVENT_LIST = ["PushEvent", "CreateEvent", "ForkEvent"]
  PROVIDER_TO_POST_TYPE = { "twitter" => "tweets", "github" => "github_events"}
  attr_accessible :user_name, :provider, :uid, :user_id

  belongs_to :user
  has_many :tweets

  def self.create_with_omniauth(auth, user)
    create! do |subscription|
      subscription.provider = auth["provider"]
      subscription.uid = auth["uid"]
      subscription.user_name = auth["info"]["nickname"]
      subscription.user_id = user.id
    end
  end

  def self.get_all_new_service_posts
    Subscription.all.each do |subscription|
      new_posts = subscription.get_new_posts
      subscription.create_records_of_posts(new_posts)
    end
    self.delay(
      :run_at =>
      SUBSCRIPTION_FREQ.seconds.from_now
    ).get_all_new_service_posts
  end

  def get_new_posts
    posts_for(self.provider).select do |post|
      post if !post.nil? && is_a_new_post?(post)
    end
  end

  def is_a_new_post?(post)
    return_value = true
    if post.created_at.to_time.utc < self.created_at.to_time.utc
      return_value = false
    else
      self.send(PROVIDER_TO_POST_TYPE[self.provider]).each do |post_type|
        if post_type.created_at == post.created_at
          return_value = false
        end
      end
    end
    return_value
  end

  def posts_for(provider)
    self.send("get_#{PROVIDER_TO_POST_TYPE[self.provider]}")
  end

  def create_records_of_posts(new_posts)
    new_posts.each do |new_post|
      if provider == "twitter"
        create_tweet(new_post)
      elsif provider == "github"
        create_github_event(new_post)
      end
    end
  end

  def create_tweet(new_post)
    Tweet.create!(subscription_id: self.id,
                  body: new_post.text,
                  created_at: new_post.created_at,
                  poster_id: self.user_id
                 )
  end

  def create_github_event(new_post)
    GithubEvent.create!(subscription_id: self.id,
                        repo: new_post.repo.name,
                        created_at: new_post.created_at,
                        poster_id: self.user_id,
                        event_type: new_post.type
                       )
  end

  def get_tweets
    Twitter.user_timeline(self.user_name)
  end

  def get_github_events
    events = Octokit.user_events(self.user_name).select do |event|
      event if EVENT_LIST.include?(event.type)
    end
    events
  end

  def tweets
    Tweet.where(subscription_id: self.id)
  end

  def github_events
    GithubEvent.where(subscription_id: self.id)
  end

end
