module Hungrlr
  class TweetApiService
    attr_accessor :base_url, :bj_token

    def initialize(base_url, bj_token)
      @base_url, @bj_token = base_url, bj_token
    end

    def twitter_accounts
      url = "#{base_url}/users/twitter.json?token=#{bj_token}"
      accounts = Net::HTTP.get(URI(url))
      JSON.parse(accounts)["accounts"]
    end

    def build_tweet_hash(tweets)
      tweets.collect do |tweet|
        { comment: tweet.text, link: tweet.source,
          status_id: tweet.id, created_at: tweet.created_at }
      end
    end

    def create_tweets_for_user(user_id, tweets_hash)
      tweets_json = tweets_hash.to_json
      Net::HTTP.post_form( URI("#{base_url}/user_tweets"),
                           user_id: user_id,
                           tweets: tweets_json,
                           token: bj_token )
    end

  end
end