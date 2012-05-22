module Fetcher
  def self.create_twitter_post(user_id, status)
    User.find(user_id).twitter_posts.create(
      twitter_id: status.id,
      text: status.text,
      created_at: status.created_at
      )
  end

  def self.import_twitter_activity(uid, user_id, last_status_id)
    statuses = Twitter.user_timeline(user_id: uid.to_i, since_id: last_status_id.to_i)
    statuses.each do |status|
      Fetcher.create_twitter_post(user_id, status)
    end
    Fetcher.delay(run_at: 5.minutes.from_now).import_twitter_activity(uid, user_id, last_status_id)
  end


  def self.create_github_post(user_id, event)
    User.find(user_id).github_posts.create(
      repo_name: event.repo.name,
      repo_url: event.repo.url,
      github_type: event.type,
      github_id: event.id.to_i,
      created_at: event.created_at
      )
  end

  def self.import_github_activity(username, user_id, last_status_id)
    events = Octokit.user_events(username).select { |e| e.created_at > last_status_id }
    events.each do |event|
      Fetcher.create_github_post(user_id, event)
    end
    Fetcher.delay(run_at: 5.minutes.from_now).import_github_activity(username, user_id, last_status_id)
  end

  def self.import_items(provider, uid, user_id, username, last_status_id)
    case provider
    when "twitter"
      Fetcher.delay(run_at: 2.seconds.from_now, :queue => 'fetcher').import_twitter_activity(uid, user_id, last_status_id)
    when "github"
      Fetcher.delay(run_at: 2.seconds.from_now, :queue => 'fetcher').fetch_and_import_github_activity(username, user_id)
    end
  end

end