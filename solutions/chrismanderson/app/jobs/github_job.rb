require 'troutr'
class GithubJob
  @queue = :gist

  def self.perform(current_user, authentication)
    login = authentication["login"]
    client = Octokit::Client.new ({
      :login => login,
      :consumer_key => GITHUB_KEY,
      :consumer_secret => GITHUB_SECRET,
      :oauth_token => authentication["token"],
      :oauth_token_secret => authentication["secret"]})

    uid = authentication["uid"]

    user = User.find(current_user["id"])

    auth = user.authentications.find_by_provider("github")

    events =  client.user_events(login).select do |event|
      DateTime.parse(event.created_at) > auth.created_at && user.github_items.find_by_event_id(event.id).nil?
    end

    troutr = Troutr::Client.new(:token => user.authentication_token, :url => TROUTR_API_URL)

    events.reverse.each do |event|
      troutr.create_github_item(user.display_name, JSON.dump(event))
    end
  end
end

