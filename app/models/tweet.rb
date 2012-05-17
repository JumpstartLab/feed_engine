class Tweet < ActiveRecord::Base
  include PostsHelper
  attr_accessible :content, :source_id, :handle, :tweet_time
  has_one :post, :as => :postable

  def self.import_posts(user_id)
    user = User.find(user_id)

    params = {:user_id => user.twitter_id, :count=>200}
    params[:since_id] = user.tweets.last.source_id if user.tweets.any?
    Twitter.user_timeline(params).reverse.each do |tweet|
      tweet = Tweet.create(content: tweet.text, source_id: tweet.id, handle: tweet.user.screen_name, tweet_time: tweet.created_at)
      tweet.link_to_poly_post(tweet, user.feed)
    end
  end

end
