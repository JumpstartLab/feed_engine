require './app/lib/get_tweets'
class PullTwitterFeed
  @queue = :twitter

  def self.perform
    tweets = Hungrlr::TweetProcessor.new
    tweets.create_tweets
  end
end
