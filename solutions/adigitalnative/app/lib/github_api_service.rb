module Hungrlr
  class GithubApiService
    attr_accessor :base_url, :bj_token

    def initialize(base_url, bj_token)
      @base_url, @bj_token = base_url, bj_token
    end

    def github_accounts
      url = "#{base_url}/users/github.json?token=#{bj_token}"
      accounts = Net::HTTP.get(URI(url))
      JSON.parse(accounts)["accounts"]
    end

    def build_event_hash(events)
      events.collect do |event|
        event_hash = {"event_type" => event.type, "link" => event.repo.url,
                      "created_at" => event.created_at }
        if commits = event.payload.try(:commits)
          event_hash["comment"] = commits.last.message
        end
          event_hash
      end
    end

    def create_github_events_for_user(user_id, github_hash)
      github_json = github_hash.to_json
      Net::HTTP.post_form(URI("#{base_url}/user_github_events"),
                          user_id: user_id,
                          events: github_json,
                          token: bj_token)
    end
  end
end
