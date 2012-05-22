require 'json'
require 'net/http'
require 'octokit'
# require "./config/initializers/github"

module Hungrlr
  class GithubProcessor
    attr_accessor :client, :base_url, :bj_token
    EVENT_TYPES = ["PushEvent", "CreateEvent"]

    def initialize
      self.bj_token = ENV["BJ_TOKEN"].present? ? ENV["BJ_TOKEN"] : "HUNGRLR"
      self.base_url = ENV["DOMAIN"].present? ? ENV["DOMAIN"] : "http://api.hungrlr.dev/v1"
    end

    def run
      github_accounts.each do |account|
        github_hash = build_event_hash_for(account["nickname"],
                                           account["last_status_id"])
        create_github_events_for_user(account["user_id"], github_hash)
      end
    end

    def github_accounts
      accounts = Net::HTTP.get(URI("#{base_url}/users/github.json?token=#{bj_token}"))
      JSON.parse(accounts)["accounts"]
    end

    def build_event_hash_for(nickname, last_status_id)
      get_github_events_for_user(nickname, last_status_id).collect do |event|
        event_hash = {"event_type" => event.type, "link" => event.repo.url,
                      "created_at" => event.created_at }
        commits = event.payload.commits
        event_hash["comment"] = commits.last.message if commits
        event_hash
        # event_hash = {}
        # event_hash["event_type"] = event.type
        # event_hash["link"] = event.repo.url
        # event_hash["created_at"] = event.created_at
      end
    end

    def create_github_events_for_user(user_id, github_hash)
      github_json = github_hash.to_json
      Net::HTTP.post_form(URI("#{base_url}/user_github_events"),
                          user_id: user_id,
                          events: github_json,
                          token: bj_token)
    end

    def get_github_events_for_user(nickname, last_status_id)
      all_github_events_for_user(nickname).select do |event|
        should_store?(event) and new_event?(last_status_id)
      end
    end

    private

    def all_github_events_for_user(nickname)
      Octokit.user_events(nickname)
    end

    def should_store?(event)
      EVENT_TYPES.include?(event.type)
    end

    def new_event?(event, last_status_id)
      event.created_at > last_status_id
    end
  end
end
