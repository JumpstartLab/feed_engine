require 'json'
require 'open-uri'
require 'net/http'
require './config/initializers/instagram'

module Hungrlr
  class InstagramProcessor
    attr_accessor :base_url
    TEST_ACCESS_TOKEN = "8323297.f59def8.2db06c3fdb7b4c659ae12a55ffe2c44d"

    def initialize
      self.base_url = ENV["DOMAIN"] != "" ? ENV["DOMAIN"] : "http://api.hungrlr.dev/v1"
    end

    def instagram_accounts
      accounts = Net::HTTP.get(URI("#{base_url}/users/instagram.json?token=HUNGRLR"))
      JSON.parse(accounts)["accounts"]
    end

    def get_photos(instagram_id, token, last_status_id)
      #FIX THIS
      url = "https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?access_token=#{TEST_ACCESS_TOKEN}&min_timestamp=1"
      # raise url.inspect
      JSON.parse(open(url).read)["data"]
    end

    def build_photos_hash(photos)
      photos.collect do |photo_data|
        parse_instagram_data(photo_data)
      end
    end

    def parse_instagram_data(photo_data)
      photo_hash = { "link"                => photo_data["link"],
                     "original_created_at" => Time.at(photo_data["created_time"].to_i).to_s }
      photo_hash["comment"] = photo_data["caption"]["text"] if photo_data["caption"]
      photo_hash
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
                              Time.parse(account["last_status_id"]).to_i)
        photos_hash = build_photos_hash(response)
        create_photos_for_user(account["user_id"], photos_hash)
      end
    end
  end
end
