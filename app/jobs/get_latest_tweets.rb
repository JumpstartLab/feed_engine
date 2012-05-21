module GetLatestTweets
  @queue = :tweets_low
  def self.perform()
    Authentication.find_all_by_provider("twitter").each do |auth|
      Tweet.import_posts(auth.user.id)
    end    
  end
end