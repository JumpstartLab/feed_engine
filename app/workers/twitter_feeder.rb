class TwitterFeeder
  @queue = :twitter_queue
  def self.perform(user_id)
    user = User.find(user_id)
    user.import_posts('twitter')
  end
end