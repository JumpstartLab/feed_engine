require 'json'
require 'open-uri'
require 'net/http'
require_relative "../../config/initializers/instagram"
require_relative 'instagram_api_service'


module Hungrlr
  class InstagramProcessor
    attr_accessor :base_url, :bj_token, :api_service

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
      url = "https://api.instagram.com/v1/users/#{instagram_id}/media/recent?access_token=#{token}&min_timestamp=#{last_status_id + 1}"
      data = open(url)
      JSON.parse(data)["data"]
    end

    def api_service
      @api_service ||= begin
        InstagramApiService.new(base_url, bj_token)
      end
    end

    def bj_token
      ENV["BJ_TOKEN"].present? ? ENV["BJ_TOKEN"] : "HUNGRLR"
    end

    def base_url
      ENV["DOMAIN"].present? ? ENV["DOMAIN"] : "http://api.hungrlr.dev/v1"
    end
  end
end
