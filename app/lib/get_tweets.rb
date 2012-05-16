require 'json'
require 'net/http'
require 'twitter'
require "./config/initializers/twitter"

module Hungrlr
  class TweetProcessor
    attr_accessor :client, :base_url

    def initialize
      self.base_url = ENV["DOMAIN"] == "" ? ENV["DOMAIN"] : "http://api.lvh.me:3000/v1"
      self.client   = Twitter::Client.new(:consumer_key    => TWITTER_KEY,
                                          :consumer_secret => TWITTER_SECRET)
    end

    def create_tweets_for_user(nickname, tweets_hash)
      tweets_json = tweets_hash.to_json
      Net::HTTP.post_form( URI("#{base_url}/user_tweets"),
                           nickname: nickname,
                           tweets: tweets_json,
                           token: "HUNGRLR")

    end

    def collect_all_tweets
      fetch_accounts["accounts"].each do |account|
        tweets = get_tweets(account["nickname"], account["last_status_id"])
        tweets_hash = prepare_tweets(tweets)
        create_tweets_for_user(account["nickname"], tweets_hash)
      end
    end

    def fetch_accounts
      accounts = Net::HTTP.get(URI("#{base_url}/users.json?token=HUNGRLR"))
      JSON.parse(accounts)
    end

    def get_tweets(nickname, last_status_id)
      client.user_timeline(nickname, since_id: last_status_id)
    end

    def prepare_tweets(tweets)
      tweets.collect do |tweet|
        {
          comment: tweet.text,
          link: tweet.source,
          external_id: tweet.id,
          created_at: tweet.created_at,
        }
      end
    end
  end
end

tc = Hungrlr::TweetProcessor.new
tc.collect_all_tweets