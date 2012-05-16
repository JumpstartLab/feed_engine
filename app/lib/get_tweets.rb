require 'json'
require 'net/http'
require 'twitter'
require "./config/initializers/twitter"

module Hungrlr
  class TweetProcessor
    attr_accessor :client, :base_url

    def initialize
      self.base_url = ENV["DOMAIN"] == "" ? ENV["DOMAIN"] : "http://api.hungrlr.dev/v1"
      self.client   = Twitter::Client.new(:consumer_key    => TWITTER_KEY,
                                          :consumer_secret => TWITTER_SECRET)
    end

    def create_tweets
      tweets_json = collect_all_tweets.to_json
      Net::HTTP.post_form( URI("#{base_url}/user_tweets"),
                           tweets: tweets_json)
    end
    
    def collect_all_tweets
      fetch_accounts["accounts"].collect do |account|
        tweets = get_tweets(account["nickname"], account["last_status_id"])
        prepare_tweets(tweets, account["user_id"])
      end
    end

    def fetch_accounts
      accounts = Net::HTTP.get(URI("#{base_url}/users"))
      JSON.parse(accounts)
    end

    def get_tweets(nickname, last_status_id)
      client.user_timeline(nickname, since_id: last_status_id)
    end

    def prepare_tweets(tweets, user_id)
      tweets.collect do |tweet|
        {
          comment: tweet.text,
          link: tweet.source,
          external_id: tweet.id,
          created_at: tweet.created_at,
          user_id: user_id
        }
      end
    end
  end
end