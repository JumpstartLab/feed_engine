require 'json'
require 'open-uri'
require 'net/http'
require './config/initializers/instagram'

module Hungrlr
  class InstagramProcessor
    attr_accessor :base_url, :bj_token
    TEST_ACCESS_TOKEN = "8323297.f59def8.2db06c3fdb7b4c659ae12a55ffe2c44d"

    def initialize
      self.bj_token = ENV["BJ_TOKEN"].present? ? ENV["BJ_TOKEN"] : "HUNGRLR"
      self.base_url = ENV["DOMAIN"].present? ? ENV["DOMAIN"] : "http://api.hungrlr.dev/v1"
    end

    private

    def get_photos(instagram_id, token, last_status_id)
      url = "https://api.instagram.com/v1/users/#{instagram_id}/media/recent?access_token=#{TEST_ACCESS_TOKEN}&min_timestamp=#{last_status_id}"
      JSON.parse(open(url).read)["data"]
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
