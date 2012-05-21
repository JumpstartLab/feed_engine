class InstagramFeedItem < ActiveRecord::Base
  attr_accessible :image_url, :comment, :posted_at, :user_id, :instagram_id

  belongs_to :user
  before_create :validates_timeliness_of_post
  
  def self.import(user, media_item)
    unless user.instagram_feed_items.map(&:instagram_id).include?(media_item.id)
      create_from_instagram(user, media_item)
    end

    # unless user.twitter_feed_items.map(&:tweet_id).include?(tweet.id)
    #   create_from_tweet(user, tweet)
    # end
  end

  def self.create_from_instagram(user, instagram)
    caption = instagram.caption ? instagram.caption.text : ''
    user.instagram_feed_items.create(instagram_id: instagram.id,
                                    posted_at: Time.at(instagram.created_time.to_i),
                                    image_url: instagram.images.standard_resolution.url,
                                    comment: caption)
  end

  def decorate
    InstagramFeedItemDecorator.decorate(self)
  end

  def validates_timeliness_of_post
    if posted_at < user.instagram_authentication.created_at
      errors.add(:posted_at, "Feed item too early")
    end
  end
end
