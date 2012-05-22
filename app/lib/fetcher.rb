module Fetcher
  def self.import_twitter_activity(twitter_user_id, user_name, last_status_id)
    statuses = Twitter.user_timeline(user_id: twitter_user_id.to_i, since_id: last_status_id.to_i)
    statuses.each do |status|
      Fetcher.create_twitter_post(user_id, status)
    end
    Fetcher.delay(run_at: 5.minutes.from_now).import_twitter_activity(uid, user_id, last_status_id)
  end

  def self.import_github_activity(username, user_name, last_status_id)
    events = Octokit.user_events(username).select { |e| e.created_at > last_status_id }
    events.each do |event|
      Fetcher.create_github_post(user_id, event)
    end
    Fetcher.delay(run_at: 5.minutes.from_now).import_github_activity(username, user_id, last_status_id)
  end

  private

  def self.client_for(token)
    @client =
      if Rails.env.production?
        FeedEngineApi::Client.new(host: "http://api.feedonkulous.com", port: 80, token: token)
      else
        FeedEngineApi::Client.new(host: "http://api.lvh.me", port: 3000, token: token)
      end
  end

  def self.create_twitter_post(user, status)
    client_for(user.authentication_token).create_post(
      user.display_name,
      type:       "TwitterPost",
      twitter_id: status.id,
      text:       status.text,
      created_at: status.created_at
    )
  end

  def self.create_github_post(user, event)
    client_for(user.authentication_token).create_post(
      user.display_name,
      type:        "GithubPost",
      repo_name:   event.repo.name,
      repo_url:    event.repo.url,
      github_type: event.type,
      github_id:   event.id.to_i,
      created_at:  event.created_at
    )
  end
end
