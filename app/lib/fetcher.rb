require 'hashie'

module Fetcher
  def self.import_twitter_activity(user, twitter_user_id, last_status_id)
    statuses = Twitter.user_timeline(user_id: twitter_user_id.to_i, since_id: last_status_id.to_i)
    statuses.each do |status|
      Fetcher.create_twitter_post(user, status)
    end
    Fetcher.delay(run_at: next_time).import_twitter_activity(user, twitter_user_id, last_status_id)
  end

  def self.import_github_activity(user, github_username, last_status_id)
    events = Octokit.user_events(github_username).select { |e| e.created_at > last_status_id }
    events.each do |event|
      Fetcher.create_github_post(user, event)
    end
    Fetcher.delay(run_at: next_time).import_github_activity(user, github_username, last_status_id)
  end

  def self.import_instagram_activity(user)
    images = get_instagram_images(username).select { |e| e.created_at > last_status_id }
    events.each do |event|
      Fetcher.create_github_post(user, event)
    end
    Fetcher.delay(run_at: next_time).import_instagram_activity(user)
  end

  private

  def self.next_time
    1.minutes.from_now
  end

  def self.create_instagram_post(user, image)
    client_for(user.authentication_token).create_post(
      user.display_name,
      type:         "InstagramPost",
      instagram_id: image[:id],
      url:          image[:url],
    )
  end

  def self.get_instagram_images(user)
    feed = get_instagram_feed(user)
    feed.data.map do |data|
      next unless data.type == "image"

      url = data.images.standard_resolution.url
      id  = data.id

      {url: url, id: id}
    end.compact
  end

  def self.get_instagram_feed(user)
    token = user.auth_for("instagram").token
    url = "https://api.instagram.com/v1/users/self/feed"
    connection = Faraday.new(:url => url)

    response = connection.get do |req|
      req.url(url)
      req.headers['Accept']     = 'application/json'
      req.params[:access_token] = token
      req.params[:min_id]       = min_id
    end

    JSON.parse(response.body)

    Hashie::Mash.new(json)
  end

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
