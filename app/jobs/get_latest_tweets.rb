module GetLatestTweets
  @queue = :tweets_low
  def self.perform()
    Authentication.find_all_by_provider("twitter").each do |auth|
      auth.user.import_posts('twitter')
    end    
  end
end