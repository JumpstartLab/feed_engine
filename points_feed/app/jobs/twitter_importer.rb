class TwitterImporter
  @queue = :medium

  def self.perform
    authentications_with_twitter.each do |authentication|
      import_tweets(authentication)
    end
  end

  private

  def self.authentications_with_twitter
    Authentication.joins("JOIN users ON users.id == user_id")
              .where("user_id is NOT NULL and provider is ?", "twitter")
              .includes("user")
  end

  def self.import_tweets(authentication)
    authentication.user.twitter.user_timeline(authentication.uid.to_i).each do |tweet|
      TwitterFeedItem.import(authentication.user, tweet)
    end
  end
end