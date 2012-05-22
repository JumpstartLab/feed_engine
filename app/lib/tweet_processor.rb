require 'json'
require 'net/http'
require 'twitter'
require_relative "../../config/initializers/twitter"
require_relative 'tweet_api_service'

module Hungrlr
  class TweetProcessor
    def run
      api_service.twitter_accounts.each do |account|
        response = get_tweets(account["nickname"], account["last_status_id"])
        tweets_hash = api_service.build_tweet_hash(response)
        api_service.create_tweets_for_user(account["user_id"], tweets_hash)
      end
    end

    # private

    def client
      @client ||= Twitter::Client.new(:consumer_key    => TWITTER_KEY,
                                      :consumer_secret => TWITTER_SECRET)
    end

    def api_service
      @api_service ||= begin
        bj_token = ENV["BJ_TOKEN"].present? ? ENV["BJ_TOKEN"] : "HUNGRLR"
        base_url = ENV["DOMAIN"].present? ? ENV["DOMAIN"] : "http://api.hungrlr.dev/v1"
        
        TweetApiService.new(base_url, bj_token)
      end
    end

    def get_tweets(nickname, last_status_id)
      client.user_timeline(nickname, since_id: last_status_id)
    end

  end
end
