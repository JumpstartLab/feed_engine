require 'json'
require 'net/http'
require 'octokit'
require_relative "../../config/initializers/github"
require_relative 'github_api_service'


module Hungrlr
  class GithubProcessor
    attr_accessor :base_url, :bj_token
    EVENT_TYPES = ["PushEvent", "CreateEvent"]

    def run
      github_accounts.each do |account|
        response = get_github_events_for_user(account["nickname"], account["last_status_id"])
        github_hash = api_service.build_event_hash(response)
        api_service.create_github_events_for_user(account["user_id"], github_hash)
      end
    end

    def get_github_events_for_user(nickname, last_status_id)
      all_github_events_for_user(nickname).select do |event|
        should_store?(event) and new_event?(event, last_status_id)
      end
    end

    def api_service
      @api_service ||= begin
        bj_token = ENV["BJ_TOKEN"].present? ? ENV["BJ_TOKEN"] : "HUNGRLR"
        base_url = ENV["DOMAIN"].present? ? ENV["DOMAIN"] : "http://api.hungrlr.dev/v1"
        GithubApiService.new(base_url, bj_token)
      end
    end

    def github_accounts
      api_service.github_accounts
    end

    def all_github_events_for_user(nickname)
      Octokit.user_events(nickname)
    end

    def should_store?(event)
      EVENT_TYPES.include?(event.type)
    end

    def new_event?(event, last_status_id)
      DateTime.parse(event.created_at).to_i > DateTime.parse(last_status_id).to_i
    end
  end
end
