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

class Subscription < ActiveRecord::Base
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

  def self.get_all_new_tweets
    twitter_subscriptions.each do |t_subscription|
      t_subscription.get_new_tweets
    end
    self.delay(:run_at => GET_TWEET_FREQUENCY.seconds.from_now).get_all_new_tweets
  end

  def get_new_tweets
    new_tweets = []
    i = 0
    while true do
      tweet = Twitter.user_timeline(self.user_name)[i]
      if tweet.created_at > (Time.now - GET_TWEET_FREQUENCY)
        new_tweets << tweet
      else
        break
      end
      i += 1
    end
    new_tweets.each do |new_tweet|
      t = Tweet.create(subscription_id: self.id,
                       body: new_tweet.text,
                       created_at: new_tweet.created_at,
                       poster_id: self.user_id
                      )
    end
  end

  def self.twitter_subscriptions
    Subscription.where(provider: "twitter")
  end
end
