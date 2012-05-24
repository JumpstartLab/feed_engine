require 'feed_engine_api'
require 'feeder/twitter_fetcher'
require 'feeder/github_fetcher'
require 'feeder/instagram_fetcher'

module Feeder
  class Worker
    TWO_MINUTES = 2*60

    def self.start
      new.start
    end

    def start
      while true
        refeed_authentications
        refeed_relationships_posts
        sleep TWO_MINUTES
      end
    end

    private

    def refeed_authentications
      users = client(MASTER_TOKEN).users
      users.each do |user|
        twitter   = user.auth.twitter
        github    = user.auth.github
        instagram = user.auth.instagram

        if twitter
          refeed_twitter(user, twitter)
        end

        if github
          refeed_github(user, github)
        end

        if instagram
          refeed_instagram(user, instagram)
        end
      end
    end

    def refeed_relationship_posts
      relationships = client(MASTER_TOKEN).relationships
      relationships.each do |relationship|
        followed = User.find_by_display_name(relationship.followed)
        follower = User.find_by_display_name(relationship.follower)
        since_id = relationship.since_id

        client(follower.id).refeed_post
      end
    end

    def refeed_twitter(user, auth)
      log_exceptions do
        tweets = TwitterFetcher.fetch(auth.user_id, auth.since_id)
        tweets.each do |tweet|
          client(user.token).create_post(
            user.display_name,
            type:       "TwitterPost",
            twitter_id: tweet.id,
            text:       tweet.text,
            created_at: tweet.created_at
          )
        end
      end
    end

    def refeed_github(user, auth)
      log_exceptions do
        events = GithubFetcher.fetch(auth.username, auth.since_id)
        events.each do |event|
          client(user.token).create_post(
            user.display_name,
            type:        "GithubPost",
            repo_name:   event.repo.name,
            repo_url:    event.repo.url,
            github_type: event.type,
            github_id:   event.id.to_i,
            created_at:  event.created_at
          )
        end
      end
    end

    def refeed_instagram(user, auth)
      log_exceptions do
        images = InstagramFetcher.fetch(auth.token, auth.since_id)
        images.each do |image|
          client(user.token).create_post(
            user.display_name,
            type:         "InstagramPost",
            instagram_id: image[:id],
            url:          image[:url]
          )
        end
      end
    end

    def client(token)
      if production?
        FeedEngineApi::Client.new(host: "http://api.feedonkulous.com", port: 80, token: token)
      else
        FeedEngineApi::Client.new(host: "http://api.lvh.me", port: 3000, token: token)
      end
    end

    def production?
      (ENV["RACK_ENV"] || ENV["RAILS_ENV"]) == "production"
    end

    def log_exceptions(&block)
      block.call
    rescue Exception => err
      log("ERROR:\n#{err.message}\n#{err.backtrace.join("\n")}")
    end

    def log(message)
      puts message
    end
  end
end
