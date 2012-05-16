class TwitterFeeder
  @queue = :twitter_queue
  def self.perform(user_id)
    Tweet.import_tweets(user_id)
  end
end