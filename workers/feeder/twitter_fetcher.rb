require 'twitter'

module Feeder
  module TwitterFetcher
    def self.fetch(user_id, last_status_id)
      Twitter.user_timeline(user_id: user_id.to_i, since_id: last_status_id.to_i)
    end
  end
end
