require 'octokit'
module Feeder
  module GithubFetcher
    def self.fetch(username, last_id)
      Octokit.user_events(username).
        select { |e| e.created_at > last_id }
    end
  end
end
