class TwitterImporter
  @queue = :medium

  def self.perform
    users_with_twitter.each do |user|
      import_tweets(user)
    end
  end

  private

  def self.users_with_twitter
    puts [:debug, :users_with_twitter].inspect
    User.where("twitter_name IS NOT null")
  end

  def self.import_tweets(user)
    puts [:debug, :import_tweets].inspect
    Twitter.user_timeline(user.twitter_name).each do |tweet|
      puts tweet.text
      TwitterFeedItem.import(user, tweet)
    end
  end
end