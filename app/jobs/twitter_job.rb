class TwitterJob
  @queue = :tweet 

  def self.perform(current_user, authentication)
    raise authentication.inspect
   client = Twitter::Client.new ({
    :consumer_key => ENV["TWITTER_DEV_KEY"],
    :consumer_secret => ENV["TWITTER_DEV_SECRET"],
    :oauth_token => authentication["token"],
    :oauth_token_secret => authentication["secret"]})
  uid = authentication["uid"] 

  user = User.find(current_user["id"])
  client.user_timeline(uid.to_i).reverse.each do |tweet| 
    twitter_item = user.twitter_items.create(:tweet => tweet)
    user.add_stream_item(twitter_item)
  end 
  user.save
  end 
end 