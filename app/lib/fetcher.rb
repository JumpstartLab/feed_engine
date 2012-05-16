module Fetcher

    # defaults to 20, unless it doesn't
  def self.fetch_tweets(user, count=nil)
    if count
      Twitter.user_timeline(user_id: user.auth_for("twitter").uid.to_i, 
                            count: count)
    else
      Twitter.user_timeline(user_id: user.auth_for("twitter").uid.to_i)
    end
  end

  def self.create_post_from_twitter(user, status)
    user.twitter_posts.create(
      twitter_id: status.id,
      text: status.text,
      published_at: status.created_at
      )
  end

end