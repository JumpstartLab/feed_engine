require 'json'
require 'open-uri'
require './config/initializers/instagram'

module Hungrlr
  class InstagramProcessor
    attr_accessor :base_url
    TEST_ACCESS_TOKEN = "144555019.f59def8.ad06cea44cff4ad3baecc818be18a080"

    def initialize
      # self.base_url = ENV["DOMAIN"] == "" ? ENV["DOMAIN"] : "http://api.lvh.me:3000/v1"
    end

    def instagram_accounts
      [
      {
        user_id: 8323297
      }
      ]
    end

    def get_photos(user_id)
      url = "https://api.instagram.com/v1/users/#{user_id}/media/recent/?access_token=#{TEST_ACCESS_TOKEN}"
      JSON.parse(open(url).read)["data"]
    end

    def build_photo_hash(photos)
      photos.collect do |photo|
        {
          comment: photo["caption"], link: photo["link"],
          created_at: Time.at(photo["created_time"].to_i).to_date
        }
      end
    end

    def run
      instagram_accounts.each do |account|
        response = get_photos(account[:user_id])
        puts response.first
        photo_hash = build_photo_hash(response)
        puts photo_hash
      end
    end
  end
end
