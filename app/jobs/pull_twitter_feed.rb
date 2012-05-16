require './app/lib/tweet_processor'

class PullTwitterFeed
  @queue = :twitter

  def self.perform
    tweets = Hungrlr::TweetProcessor.new
    tweets.create_tweets
  end
end
