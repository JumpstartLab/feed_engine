class GithubFeedItem < ActiveRecord::Base
  attr_accessible :content, :posted_at, :user_id, :github_id, :event_type

  belongs_to :user
  has_many :awards, as: :awardable
  include PointAwarder

  def self.import(user, event)
    unless user.github_feed_items.map(&:github_id).include?(event.id.to_i)
      create_from_event(user, event)
    end

    # unless user.twitter_feed_items.map(&:tweet_id).include?(tweet.id)
    #   create_from_tweet(user, tweet)
    # end
  end

  def self.create_from_event(user, event)
    if event.payload.commits
      user.github_feed_items.create(event_type: event.type,
                                    github_id: event.id,
                                    posted_at: event.created_at,
                                    content: event.payload.commits.last.message)
    end
  end

  def decorate
    GithubFeedItemDecorator.decorate(self)
  end

  def validates_timeliness_of_post
    if self.posted_at < user.github_authentication.created_at
      errors.add(:posted_at, "Feed item too early")
    end
  end
end
