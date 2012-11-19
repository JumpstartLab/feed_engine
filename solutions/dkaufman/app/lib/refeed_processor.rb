require 'json'
require 'net/http'
require 'twitter'
require "./config/initializers/twitter"

module Hungrlr
  class RefeedProcessor
    attr_accessor :base_url, :bj_token

    def initialize
      self.bj_token = ENV["BJ_TOKEN"].present? ? ENV["BJ_TOKEN"] : "HUNGRLR"
      self.base_url = ENV["DOMAIN"].present? ? ENV["DOMAIN"] : "http://api.hungrlr.dev/v1"
    end

    def subscriptions
      subscriptions = Net::HTTP.get(URI("#{base_url}/subscriptions.json?token=#{bj_token}"))
      JSON.parse(subscriptions)["subscriptions"]
    end

    def get_growls(user_slug, last_status_id)
      growls = Net::HTTP.get(URI("#{base_url}/feeds/#{user_slug}/growls.json?token=#{bj_token}&since=#{last_status_id}"))
      JSON.parse(growls)["growls"]
    end

    def create_regrowls_for(subscription, growls)
      user_slug = subscription["user_slug"]
      subscriber_token = subscription["subscriber_token"]
      id = subscription["id"]

      growls.each do |growl|
        uri_path = URI("#{base_url}/feeds/#{user_slug}/growls/#{growl["id"]}/refeed")
        Net::HTTP.post_form(uri_path, token: subscriber_token, subscription_id: id)
      end
    end

    def run
      subscriptions.each do |subscription|
        growls = get_growls(subscription["user_slug"], subscription["last_status_id"])
        create_regrowls_for(subscription, growls)
      end
    end
  end
end