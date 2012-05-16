class GithubJob
  @queue = :gist

  def self.perform(current_user, authentication)
    client = Octokit::Client.new({
    :consumer_key => ENV[""],
    :consumer_secret => ENV[""],
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
  end
end
