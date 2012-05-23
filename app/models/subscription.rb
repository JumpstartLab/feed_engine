# == Schema Information
#
# Table name: subscriptions
#
#  id           :integer         not null, primary key
#  provider     :string(255)
#  uid          :string(255)
#  user_name    :string(255)
#  user_id      :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  oauth_token  :string(255)
#  oauth_secret :string(255)
#

# The model for any external subscriptions
class Subscription < ActiveRecord::Base
  EVENT_LIST = ["PushEvent", "CreateEvent", "ForkEvent"]
  PROVIDER_TO_POST_TYPE = { "twitter" => "tweets", "github" => "github_events",
                            "instagram" => "instapounds",
                            "refeed" => "refeeds" }
  attr_accessible :user_name, :provider, :uid, :user_id, :oauth_token,
    :oauth_secret, :original_poster
  attr_accessor :original_poster

  belongs_to :user

  def self.create_with_omniauth(auth, user)
    create! do |subscription|
      subscription.provider = auth["provider"]
      subscription.uid = auth["uid"]
      subscription.user_name = auth["info"]["nickname"]
      subscription.user_id = user.id
      subscription.oauth_token = auth["credentials"]["token"]
      subscription.oauth_secret = auth["credentials"]["secret"]
    end
  end

  def self.create_with_refeed(poster_id, refeeder_id)
    create! do |subscription|
      subscription.uid = poster_id
      subscription.user_id = refeeder_id
      subscription.provider = "refeed"
    end
  end

  def self.get_all_new_service_posts
    Subscription.all.each do |subscription|
      new_posts = subscription.get_new_posts
      subscription.create_records_of_posts(new_posts)
    end
    self.delay(
      :run_at =>
      SUBSCRIPTION_FREQ.seconds.from_now
    ).get_all_new_service_posts
  end

  def original_poster
    User.find(uid.to_i)
  end

  def base_url
    BASE_URL
  end

  def get_new_posts
    posts_for(self.provider).select do |post|
      post if !post.nil? && is_a_new_post?(post)
    end
  end

  def is_a_new_post?(post)
    return_value = true
    if post.created_at.to_time.utc < self.created_at.to_time.utc
      return_value = false
    else
      self.send(PROVIDER_TO_POST_TYPE[self.provider]).each do |post_type|
        if post_type.created_at == post.created_at
          return_value = false
        end
      end
    end
    return_value
  end

  def posts_for(provider)
    self.send("get_#{PROVIDER_TO_POST_TYPE[self.provider]}")
  end

  def create_records_of_posts(new_posts)
    new_posts.each do |new_post|
      if provider == "twitter"
        create_tweet(new_post)
      elsif provider == "github"
        create_github_event(new_post)
      elsif provider == "instagram"
        create_instapound(new_post)
      elsif provider == "refeed"
        create_refeed(new_post)
      end
    end
  end

  def create_tweet(new_post)
    HTTParty.post("http://api.#{base_url}/v1/feeds/"+
                  "#{user.subdomain}/items.json",
                  body: {
                    api_key: user.api_key,
                    display_name: user.display_name,
                    post: {
                      type: "tweet",
                      subscription_id: self.id,
                      body: new_post.text,
                      created_at: new_post.created_at
                    }
                  }
                 )
                 # Tweet.create!(subscription_id: self.id,
                 #               body: new_post.text,
                 #               created_at: new_post.created_at,
                 #               poster_id: self.user_id
                 #              )
  end

  def fancy_type(event_type)
    if event_type == "PushEvent"
      "Github push!"
    elsif event_type == "ForkEvent"
      "Github fork!"
    else
      "Github created!"
    end
  end

  def create_github_event(new_post)
    HTTParty.post("http://api.#{base_url}/v1/feeds/"+
                  "#{user.subdomain}/items.json",
                  body: {
                    api_key: user.api_key,
                    display_name: user.display_name,
                    post: {
                      type: "github_event",
                      subscription_id: self.id,
                      repo: new_post.repo.name,
                      body: new_post.text,
                      created_at: new_post.created_at,
                      event_type: fancy_type(new_post.type)
                    }
                  }
                 )
  end

  def create_instapound(new_post)
    Instapound.create!(subscription_id: self.id,
                       body: new_post.caption["text"],
                       image_url: new_post.images["standard_resolution"]["url"],
                       created_at: new_post.created_at,
                       poster_id: self.user_id
                      )
  end

  def create_refeed(new_post)
    HTTParty.post("#{new_post.link}/refeeds.json",
                  :body => { :api_key => user.api_key } )
  end

  def get_tweets
    Twitter.user_timeline(self.user_name)
  end

  def get_github_events
    events = Octokit.user_events(self.user_name).select do |event|
      event if EVENT_LIST.include?(event.type)
    end
    events
  end

  def get_instapounds
    all_instaposts = HTTParty.get(
      "https://api.instagram.com/v1/users/" +
      "#{self.uid}/media/recent/?access_token=#{self.oauth_token}"
    )["data"]
    objectified_instaposts = all_instaposts.map do |instapost|
      objectified_instapost = OpenStruct.new instapost
      objectified_instapost.created_at = Time.at(
        objectified_instapost.created_time.to_i
      ).to_datetime.utc
      objectified_instapost
    end
  end

  def get_refeeds
    all_refeeds = HTTParty.get("http://api.#{base_url}/v1/feeds/" +
                               "#{original_poster.subdomain}/items.json")["items"]["most_recent"]

                               objectified_refeeds = all_refeeds.map do |refeed|
                                 objectified_refeed = OpenStruct.new refeed
                                 objectified_refeed
                               end
  end

  def tweets
    Tweet.where(subscription_id: self.id)
  end

  def github_events
    GithubEvent.where(subscription_id: self.id)
  end

  def instapounds
    Instapound.where(subscription_id: self.id)
  end

  def refeeds
    # all_items = JSON.parse(HTTParty.get(
    #   "http://api.#{base_url}/v1/feeds/" +
    #   "#{user.subdomain}/items.json"
    # ))
    # refeeded_items = all_items.select do |item|
    #   OpenStruct.new item unless item.original_poster_id.nil?
    # end
    # refeeded_items
    Item.where(poster_id: self.user_id).select(&:refeed?)
  end

end
