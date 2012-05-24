require 'twitter'

module Feeder
  module TwitterFetcher
    def self.fetch(user_id, last_status_id)
      Twitter.user_timeline(user_id: user_id.to_i, since_id: last_status_id.to_i)
    end
  end
end

Twitter.configure do |config|
  config.consumer_key       = 'UpoPl9KlDJJlzVf7poMeFQ'
  config.consumer_secret    = 'GOskrA43L9LM9FWAmzVJ2vjtPTHfEgLKYdubuAK3I'
  config.oauth_token        = '14452805-tfjOhxSe7x1QjeGTQqgY1T8ftpWuUBRTwVQRw8WM0'
  config.oauth_token_secret = '9KLhVY9dGCRBiySl680U4Ka33rF9DCX9ZW0psykHE'
end
