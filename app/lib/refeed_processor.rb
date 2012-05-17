require 'json'
require 'net/http'
require 'twitter'
require "./config/initializers/twitter"

module Hungrlr
  class RefeedProcessor
    attr_accessor :base_url

    def initialize
      self.base_url = ENV["DOMAIN"] == "" ? ENV["DOMAIN"] : "http://api.lvh.me:3000/v1"
    end

    def subscriptions
      subscriptions = Net::HTTP.get(URI("#{base_url}/subscriptions.json?token=HUNGRLR"))
      JSON.parse(subscriptions)["subscriptions"]
    end

    def get_growls(user_slug, last_status_id)
      growls = Net::HTTP.get(URI("#{base_url}/feeds/#{user_slug}.json?token=HUNGRLR&since=#{last_status_id}"))
      # puts JSON.parse(growls)["items"]["most_recent"].inspect
    end

    def create_growls_for_user(subscriber_id, growls_json)
      Net::HTTP.post_form( URI("#{base_url}/user_tweets"),
                           user_id: subscriber_id,
                           tweets: growls_json,
                           token: "HUNGRLR" )
    end

    def run
      subscriptions.each do |subscription|
        growls_json = get_growls(subscription["user_slug"], subscription["last_status_id"])
        create_tweets_for_user(subscription["subscriber_id"], growls_json)
      end
    end
  end
end

processor = Hungrlr::RefeedProcessor.new
processor.get_growls("wengzilla", "1337193551")