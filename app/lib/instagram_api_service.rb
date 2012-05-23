module Hungrlr
  class InstagramApiService
    attr_accessor :base_url, :bj_token

    def initialize(base_url, bj_token)
      @base_url, @bj_token = base_url, bj_token
    end

    def instagram_accounts
      accounts = Net::HTTP.get(URI("#{base_url}/users/instagram.json?token=#{bj_token}"))
      JSON.parse(accounts)["accounts"]
    end

    def build_photos_hash(photos)
      photos.collect do |photo_data|
        parse_instagram_data(photo_data)
      end
    end

    def parse_instagram_data(photo_data)
      photo_hash = { "link"                => photo_data["images"]["standard_resolution"]["url"],
                     "original_created_at" => Time.at(photo_data["created_time"].to_i) }
      photo_hash["comment"] = photo_data["caption"]["text"] if photo_data["caption"]
      photo_hash
    end

    def create_photos_for_user(user_id, photos_hash)
      photos_json = photos_hash.to_json
      Net::HTTP.post_form( URI("#{base_url}/user_instagram_photos"),
                           user_id: user_id,
                           photos: photos_json,
                           token: bj_token)
    end
  end
end