class GithubJob
  @queue = :gist

  def self.perform(current_user, authentication)
    login = authentication["login"]
    client = Octokit::Client.new ({
      :login => login,
      :consumer_key => ENV["GITHUB_DEV_KEY"],
      :consumer_secret => ENV["GITHUB_DEV_SECRET"],
      :oauth_token => authentication["token"],
      :oauth_token_secret => authentication["secret"]})

    uid = authentication["uid"] 
    

    user = User.find(current_user["id"])
    client.user_events(login).reverse.each do |gist| 
      github_item = user.github_items.create(:gist => gist)
      user.add_stream_item(github_item)
    end 
    user.save
  end 
end 

