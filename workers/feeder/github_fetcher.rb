module Feeder
  module GithubFetcher
    def self.fetch(username, last_event_time)
      Octokit.user_events(username).
        select { |e| e.created_at > last_event_time }
    end
  end
end
