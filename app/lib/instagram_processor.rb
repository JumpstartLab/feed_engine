require 'json'
require 'open-uri'
require 'net/http'
require_relative "../../config/initializers/instagram"
require_relative 'instagram_api_service'


module Hungrlr
  class InstagramProcessor
    attr_accessor :base_url, :bj_token, :api_service

    TEST_ACCESS_TOKEN = "8323297.f59def8.2db06c3fdb7b4c659ae12a55ffe2c44d"

    def run
      instagram_accounts.each do |account|
        response = get_photos(account["instagram_id"], account["token"],
                              Time.parse(account["last_status_id"]).to_i)
        photos_hash = api_service.build_photos_hash(response)
        api_service.create_photos_for_user(account["user_id"], photos_hash)
      end
    end

    private

    def instagram_accounts
      api_service.instagram_accounts
    end

    def get_photos(instagram_id, token, last_status_id)
      url = "https://api.instagram.com/v1/users/#{instagram_id}/media/recent?access_token=#{TEST_ACCESS_TOKEN}&min_timestamp=#{last_status_id}"
      data = Net::HTTP.get(URI(url))
      JSON.parse(data)["data"]
    end

    def api_service
      @api_service ||= begin
        bj_token = ENV["BJ_TOKEN"].present? ? ENV["BJ_TOKEN"] : "HUNGRLR"
        base_url = ENV["DOMAIN"].present? ? ENV["DOMAIN"] : "http://api.hungrlr.dev/v1"
        
        InstagramApiService.new(base_url, bj_token)
      end
    end
  end
end
