require 'json'
require 'net/http'
require 'octokit'
# require "./config/initializers/github"

module Hungrlr
  class GithubProcessor
    attr_accessor :client, :base_url
    EVENT_TYPES = ["PushEvent", "CreateEvent"]

    def initialize
      self.base_url = ENV["DOMAIN"] == "" ? ENV["DOMAIN"] : "http://api.lvh.me:3000/v1"
    end

    def github_accounts
      accounts = Net::HTTP.get(URI("#{base_url}/users/github.json?token=HUNGRLR"))
      JSON.parse(accounts)["accounts"]
    end

    def build_github_hash(events)
      events.collect do |event|
        event_hash = {}
        event_hash["event_type"] = event.type
        event_hash["link"] = event.repo.url
        event_hash["created_at"] = event.created_at
        if event.payload.commits
          event_hash["comment"] = event.payload.commits.last.message
        end
        event_hash
      end

    end

    def create_github_events_for_user(user_id, github_hash)
      github_json = github_hash.to_json
      Net::HTTP.post_form( URI("#{base_url}/user_github_events"),
                          user_id: user_id,
                          events: github_json,
                          token: "HUNGRLR")
    end

    def run
      github_accounts.each do |account|
        all_events = Octokit.user_events(account["nickname"])
        filtered_events = all_events.select{ |event| EVENT_TYPES.include?(event.type) }
        new_events = filtered_events.select{ |event| event.created_at > account["last_status_id"] }
        github_hash = build_github_hash(new_events)
        create_github_events_for_user(account["user_id"], github_hash)
      end
    end
  end
end
