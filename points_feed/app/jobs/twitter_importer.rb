class TwitterImporter
  @queue = :medium

  def self.perform
    users_with_twitter.each do |user|
      import_tweets(user)
    end
  end

  private

  def users_with_twitter
    User.where("twitter_name IS NOT null")
  end

  def import_tweets(user)
    Twitter.user_timeline(user.twitter_name).each do |tweet|

    end
  end
end