class GithubJob
  @queue = :gist

  def self.perform(current_user, authentication)
    login = authentication["login"]
    client = Octokit::Client.new ({
      :login => login,
      :consumer_key => ENV["GITHUB_KEY"],
      :consumer_secret => ENV["GITHUB_SECRET"],
      :oauth_token => authentication["token"],
      :oauth_token_secret => authentication["secret"]})

    uid = authentication["uid"] 
    

    user = User.find(current_user["id"])

    # get all events
    events = client.user_events(login)

    # sort by ascending date (newest at top)
    events = events.sort_by do |event|
      DateTime.parse(event.created_at)
    end

    # reverse to get oldest at top
    events = events.reverse

    events.each do |event|
      item = user.github_items.find_or_create_by_event_id(event.id)
      item.event = event
      item.save
    end
    user.save
  end
end

