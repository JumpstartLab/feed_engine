class TwitterFeeder
  @queue = :twitter_queue
  def self.perform(user_id)
    Tweet.import_posts(user_id)
  end
end