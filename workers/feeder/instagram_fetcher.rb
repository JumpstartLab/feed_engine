require 'hashie'

module Feeder
  module InstagramFetcher
    def self.fetch(token, min_id)
      feed = get_instagram_feed(token, min_id)
      images = feed.data.map do |data|
        next unless data.type == "image"

        url = data.images.standard_resolution.url
        id  = data.id

        {url: url, id: id}
      end.compact

      images.delete(min_id)

      images
    end

    def self.get_instagram_feed(token, min_id)
      url = "https://api.instagram.com/v1/users/self/feed"
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
  end
end
