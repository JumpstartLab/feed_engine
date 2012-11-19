require './app/lib/tweet_processor'

class PullTwitterFeed
  @queue = :twitter

  def self.perform
    tweet_processor = Hungrlr::TweetProcessor.new
    tweet_processor.run
  end
end
