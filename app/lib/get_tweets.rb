require 'json'
require 'net/http'
require 'twitter'
require "./config/initializers/twitter"

module GetTweets
  class Tweets
    attr_accessor :client
    def initialize

    end
    def send
      Net::HTTP.post_form(
                          URI("http://api.hungrlr.com/v1/user_tweets"),
                          tweets: collect_all_tweets.to_json
                          )
    end

    def collect_all_tweets
      get_users["users"].collect do |user|
        twitter_client(user["twitter_token"], user["twitter_secret"])
        prepare_tweets(user["twitter_id"], user["id"])
      end
    end

    def get_users
      users_json = Net::HTTP.get(URI("http://api.hungrlr.com/v1/user_tweets"))
      JSON.parse(users_json)
    end

    def get_tweets(twitter_id)
      if twitter_id
        client.user_timeline({:since_id => twitter_id})
      else
        client.user_timeline()
      end
    end

    def prepare_tweets(twitter_id, user_id)
      get_tweets(twitter_id).collect do |tweet|
        {
          comment: tweet.text,
          link: tweet.source,
          external_id: tweet.id,
          created_at: tweet.created_at,
          user_id: user_id
        }
      end
    end
    def twitter_client(token, secret)
      @client = Twitter::Client.new(:consumer_key => TWITTER_KEY,
                          :consumer_secret => TWITTER_SECRET,
                          :oauth_token => token,
                          :oauth_token_secret => secret)
    end
  end
end

tweet = GetTweets::Tweets.new
tweet.send
