require 'json'
require 'open-uri'
require './config/initializers/instagram'

module Hungrlr
  class InstagramProcessor
    attr_accessor :base_url
    TEST_ACCESS_TOKEN = "144555019.f59def8.ad06cea44cff4ad3baecc818be18a080"

    def initialize
      self.base_url = ENV["DOMAIN"] == "" ? ENV["DOMAIN"] : "http://api.lvh.me:3000/v1"
    end

    def instagram_accounts
      #Stubbing instagram accounts for now
      [
      { "user_id" => 1, "instagram_id" => 8323297,
        "last_status_id" => DateTime.now + 1, "token" => TEST_ACCESS_TOKEN},
      { "user_id" => 3, "instagram_id" => 2461644,
        "last_status_id" => DateTime.now + 1, "token" => TEST_ACCESS_TOKEN},
      { "user_id" => 8, "instagram_id" => 1241637,
        "last_status_id" => DateTime.now + 1, "token" => TEST_ACCESS_TOKEN}
      ]
    end

    def get_photos(instagram_id, token, last_status_id)
      # MIN_TIMESTAMP currently does not work
      url = "https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?access_token=#{TEST_ACCESS_TOKEN}"
      JSON.parse(open(url, "MIN_TIMESTAMP" => last_status_id).read)["data"]
    end

    def build_photo_hash(photos)
      photos.collect do |photo|
        {
          comment: photo["caption"], link: photo["link"],
          created_at: Time.at(photo["created_time"].to_i).to_date
        }
      end
    end

    def create_photos_for_user(user_id, photos_hash)
      photos_json = photos_hash.to_json
      Net::HTTP.post_form( URI("#{base_url}/user_instagram_photos"),
                           user_id: user_id,
                           photos: photos_json,
                           token: "HUNGRLR")
    end

    def run
      instagram_accounts.each do |account|
        response = get_photos(account["instagram_id"], account["token"],
                              account["last_status_id"].strftime("%s"))
        photos_hash = build_photo_hash(response)
        create_photos_for_user(account["user_id"], photos_hash)
      end
    end
  end
end
