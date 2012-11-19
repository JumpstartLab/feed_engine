require 'hashie'
require 'date'

module Feeder
  module InstagramFetcher
    def self.fetch(token, user_id, min_id, created_at)
      date = DateTime.parse(created_at).to_time.to_i
      feed = get_instagram_feed(token, user_id, min_id)
      images = feed.data.map do |data|
        next unless data.type == "image"

        url = data.images.standard_resolution.url
        id  = data.id
        created_at = data.created_time.to_i

        {url: url, id: id, created_at: created_at}
      end.compact

      if min_id.nil?
        images = images.select { |img| img[:created_at] > date }
      else
        images.delete(min_id)
      end

      images
    end

    def self.get_instagram_feed(token, user_id, min_id)
      url = "https://api.instagram.com/v1/users/#{user_id}/media/recent/"
      connection = Faraday.new(:url => url)

      response = connection.get do |req|
        req.url(url)
        req.headers['Accept']     = 'application/json'
        req.params[:access_token] = token
        req.params[:min_id]       = min_id if min_id
      end

      json = JSON.parse(response.body)

      Hashie::Mash.new(json)
    end

    def to_datetime
      ::DateTime.civil(*::Date._parse(self, false).values_at(:year, :mon, :mday, :hour, :min, :sec).map { |arg| arg || 0 })
    end
  end
end
