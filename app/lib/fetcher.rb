module Fetcher
  def self.create_post_from_twitter(user_id, status)
    User.find(user_id).twitter_posts.create(
      twitter_id: status.id,
      text: status.text,
      created_at: status.created_at
      )
  end

  def self.fetch_and_import_tweets(uid, user_id, last_status_id)
    statuses = Twitter.user_timeline(user_id: uid.to_i, since_id: last_status_id)
    statuses.each do |status|
      Fetcher.create_post_from_twitter(user_id, status)
    end
    Fetcher.delay(run_at: 5.minutes.from_now).fetch_and_import_tweets(uid, user_id)
  end


  def self.create_post_from_github(activity, user_id)
    User.find(user_id).github_posts.create(
      repo_name: activity.repo.name,
      repo_url: activity.repo.url,
      github_type: activity.type,
      github_id: activity.id.to_i,
      created_at: activity.created_at
      )
  end

  def self.fetch_and_import_github_activity(username, user_id)
    activities = Octokit.user_events(username)
    activities.each do |activity|
      Fetcher.create_post_from_github(activity, user_id)
    end
    Fetcher.delay(run_at: 5.minutes.from_now).fetch_and_import_github_activity(username, user_id)
  end

  def self.import_items(provider, uid, user_id, username, last_status_id)
    case provider
    when "twitter"
      Fetcher.delay(run_at: 2.seconds.from_now, :queue => 'fetcher').fetch_and_import_tweets(uid, user_id, last_status_id)
    when "github"
      Fetcher.delay(run_at: 2.seconds.from_now, :queue => 'fetcher').fetch_and_import_github_activity(username, user_id)
    end
  end

end