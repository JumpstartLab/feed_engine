class TwitterJob
  @queue = :tweet 

  def self.perform(current_user, authentication)
   Twitter.configure do |config|
    config.consumer_key = 'ubCmGXxyj0ZQ2guzFXdg'
    config.consumer_secret = 'ytoc7GZ05NqSgKZqpW0O1PjyCUiEuPrDuuHV0rLKE'
    config.oauth_token = authentication["token"]
    config.oauth_token_secret = authentication["secret"]
  end
  uid = authentication["uid"] 

  user = User.find(current_user["id"])
  Twitter.user_timeline(uid.to_i).reverse.each do |tweet| 
    twitter_item = user.twitter_items.create(:tweet => tweet)
    user.add_stream_item(twitter_item)
  end 
  user.save
  end 
end 