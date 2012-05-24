class Tweet < ActiveRecord::Base
  include PostsHelper
  attr_accessible :content, :source_id, :handle, :post_time
  has_many :points, :through => :posts
  has_many :posts, :as => :postable

  def self.import_posts(user_id)
    user = User.find(user_id)
    params = {:user_id => user.twitter_id, :count=>200}
    params[:since_id] = user.tweets.last.source_id if user.tweets.any?
    sign_up_time = user.authentications.find_by_provider('twitter').created_at
    Twitter.user_timeline(params).reverse.each do |tweet|
      if tweet.created_at > sign_up_time && Tweet.find_by_source_id(tweet.id.to_s).blank?
        tweet = Tweet.create(content: tweet.text, source_id: tweet.id, handle: tweet.user.screen_name, post_time: tweet.created_at)
        tweet.link_to_poly_post(tweet, user.feed)
      end
    end
  end
end
