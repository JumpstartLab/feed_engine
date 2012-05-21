class TwitterJob
  @queue = :tweet

  def self.perform(current_user, authentication)
    client = twitter_client(authentication["token"],authentication["secret"])

    uid = authentication['uid'].to_i

    user =  User.find(current_user["id"])

    auth = user.authentications.find_by_provider("twitter")

    tweets = client.user_timeline(uid).select do |tweet| 
      tweet.created_at.utc > auth.created_at && user.twitter_items.find_by_status_id(tweet.attrs["id_str"]).nil?
    end
    tweets.reverse.each do |tweet| 
      user.twitter_items.create(:tweet => tweet, 
                                :status_id => tweet.attrs["id_str"])
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