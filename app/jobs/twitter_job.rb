class TwitterJob
  @queue = :tweet

  def self.perform(current_user, authentication)
    client = twitter_client(authentication["token"],authentication["secret"])

    uid = authentication['uid'].to_i

    user =  User.find(current_user["id"])

    auth = user.authentications.find_by_provider("twitter")
    client.user_timeline(uid).select do |tweet| 



      end 
    # if 
    #   client.user_timeline(uid).reverse.each do |tweet| 
    #     twitter_item = user.twitter_items.create(:tweet => tweet, :tweet_time => tweet.created_at)
    #   end
    # else
    #   last_tweet_id = users_last_tweet_id(user)
    #   client.user_timeline(uid, :since_id => last_tweet_id).reverse.each do |tweet| 
    #     twitter_item = user.twitter_items.create(:tweet => tweet, :tweet_time => tweet.created_at)
    #   end
    end
    user.save
  end

  def self.users_last_tweet_id(user)
    user.last_twitter_item.tweet.id
  end

  def self.twitter_client(token,secret)
    Twitter::Client.new({
      :consumer_key => ENV["TWITTER_KEY"],
      :consumer_secret => ENV["TWITTER_SECRET"],
      :oauth_token => token,
      :oauth_token_secret => secret})
  end
end 