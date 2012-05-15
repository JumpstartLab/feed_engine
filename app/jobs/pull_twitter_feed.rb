require './app/lib/get_tweets'
class PullTwitterFeed
  @queue = :twitter

  def self.perform
    tweets = GetTweets::Tweets.new
    tweets.send
  end

end
