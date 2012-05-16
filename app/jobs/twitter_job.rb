class TwitterJob
  @queue = :tweet

  def self.perform(current_user, authentication)
   client = Twitter::Client.new ({
    :consumer_key => ENV["TWITTER_KEY"],
    :consumer_secret => ENV["TWITTER_SECRET"],
    :oauth_token => authentication["token"],
    :oauth_token_secret => authentication["secret"]})
  uid = authentication["uid"]

  user = User.find(current_user["id"])
  client.user_timeline(uid.to_i).reverse.each do |tweet|
    twitter_item = user.twitter_items.create(:tweet => tweet)
  end
  user.save
  end
end
