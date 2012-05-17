module Fetcher
  def self.create_post_from_twitter(user_id, status)
    User.find(user_id).twitter_posts.create(
      twitter_id: status.id,
      text: status.text,
      created_at: status.created_at
      )
  end

  def self.fetch_and_import_tweets(uid, user_id)
    statuses = Twitter.user_timeline(user_id: uid.to_i)
    statuses.each do |status|
      Fetcher.create_post_from_twitter(user_id, status)
    end
    #Fetcher.delay(run_at: 5.minutes.from_now).fetch_and_import_tweets(uid, user_id)
  end


  def self.create_post_from_github(username, activity, user_id)
    User.find(user_id).github_posts.create(
      repo_name: activity.repo.name,
      repo_url: activity.repo.url,
      github_type: activity.type,
      created_at: activity.created_at
      )
  end

  def self.fetch_and_import_github_activity(username, user_id)
    activities = Octokit.user_events(username)
    activities.each do |activity|
      Fetcher.create_post_from_github(username, activity, user_id)
    end
    Fetcher.delay(run_at: 5.minutes.from_now).fetch_and_import_github_activity(username, user_id)
  end

  def self.import_items(provider, uid, user_id, username)
    case provider
    when "twitter"
      Fetcher.delay(run_at: 2.seconds.from_now, :queue => 'fetcher').fetch_and_import_tweets(uid, user_id)
    when "github"
      Fetcher.delay(run_at: 2.seconds.from_now, :queue => 'fetcher').fetch_and_import_github_activity(username, user_id)
    end
  end

end