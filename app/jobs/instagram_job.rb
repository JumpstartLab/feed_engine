class InstagramJob
  @queue = :insta

  def self.perform(current_user, authentication)
    client = instagram_client(authentication["token"], authentication["secret"])

    uid = authentication["uid"].to_i

    user = User.find(current_user["id"])

    auth = user.authentications.find_by_provider("instagram")
    
    photos = client.user_media_feed(authentication["token"]).select do |photo| 
      photo.created_time > auth.created_at && user.instagram_items.find_by_image_id(image.id).nil?
    end 
    photos.reverse.each do |photo|
      user.instagram_items.create
    end
    user.save
  end

  def self.instagram_client(token, secret)
    Instagram::Client.new({
      :consumer_key => INSTAGRAM_KEY,
      :consumer_secret => INSTAGRAM_SECRET,
      :oauth_token => token,
      :oauth_token_secret => secret})
  end
end 