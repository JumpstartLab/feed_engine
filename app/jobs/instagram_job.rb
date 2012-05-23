require 'troutr'
class InstagramJob
  @queue = :insta

  def self.perform(current_user, authentication)
    uid = authentication["uid"].to_i
    user = User.find(current_user["id"])
    auth = user.authentications.find_by_provider("instagram")

    client = instagram_client(authentication["token"])
    troutr = Troutr::Client.new(:token => user.authentication_token, :url => TROUTR_API_URL)


    inst_response = client.user_recent_media
    uploads_array = inst_response


    uploads = uploads_array.select do |upload| 
      DateTime.strptime(upload.created_time,'%s') > auth.created_at && user.instagram_items.find_by_image_id(upload.id).nil?
    end

    uploads.reverse.each do |upload|
      json = JSON.dump(upload)
      troutr.create_instagram_item(user.display_name, json)
    end
  end

  def self.instagram_client(token)
    Instagram::Client.new({
      :client_id => INSTAGRAM_KEY,
      :client_secret => INSTAGRAM_SECRET,
      :access_token => token})
  end
end 

# RESPONSE
# pagination
#   data
#   data
# meta
# data?