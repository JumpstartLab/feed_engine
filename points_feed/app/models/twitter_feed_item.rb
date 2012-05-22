class TwitterFeedItem < ActiveRecord::Base
  attr_accessible :content, :posted_at, :user_id, :tweet_id

  belongs_to :user
  validate :validates_timeliness_of_post
  has_many :awards, as: :awardable
  include PointAwarder

  def self.import(user, tweet)
    unless user.twitter_feed_items.map(&:tweet_id).include?(tweet.id)
      create_from_tweet(user, tweet)
    end
  end

  def self.create_from_tweet(user, tweet)
    user.twitter_feed_items.create(content: tweet.text,
                                   posted_at: tweet.created_at,
                                   tweet_id: tweet.id)
  end

  def decorate
    TwitterFeedItemDecorator.decorate(self)
  end

  def validates_timeliness_of_post
    if self.posted_at < user.twitter_authentication.created_at
      errors.add(:posted_at, "Feed item too early")
    end
  end
end
