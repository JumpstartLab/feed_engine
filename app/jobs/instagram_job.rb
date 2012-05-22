class InstagramJob
  @queue = :insta

  def self.perform(current_user, authentication)

     uid = authentication["uid"].to_i

     user = User.find(current_user["id"])

    unless user.instagram_items.any?
      #Get all imahes, publish 5 newest? 
      
    else
      # SUBSEQUENT RUNS - only get images since last post
      
      # create all the instagrams
      # insert these items into the user's stream
      
    end
    user.save
  end

  def self.instagram_client
    Instagram::Client.new({
      :consumer_key => INSTAGRAM_KEY,
      :consumer_secret => INSTAGRAM_SECRET,
      :oauth_token => token,
      :oauth_token_secret => secret})
  end
end 