class InstagramJob
  @queue = :insta

  def self.perform(current_user, authentication)
     client = instagram_client(authentication["token"],authentication["secret"])

     uid = authentication["uid"].to_i

     user = User.find(current_user["id"])
  end 

  def self.instagram_client
    Instagram::Client.new({
      :consumer_key => ENV["INSTAGRAM_DEV_KEY"],
      :consumer_secret => ENV["INSTAGRAM_DEV_SECRET"],
      :oauth_token => token,
      :oauth_token_secret => secret})
  end
end 