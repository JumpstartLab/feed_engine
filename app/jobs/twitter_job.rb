class TwitterJob
  @queue = :tweet 

  def self.perform(current_user, authentication)
   client = Twitter::Client.new ({
    :consumer_key => 'ubCmGXxyj0ZQ2guzFXdg',
    :consumer_secret => 'ytoc7GZ05NqSgKZqpW0O1PjyCUiEuPrDuuHV0rLKE',
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