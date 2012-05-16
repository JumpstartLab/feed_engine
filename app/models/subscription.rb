# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer         not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  user_name  :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Subscription < ActiveRecord::Base
  EVENT_LIST = ["PushEvent", "CreateEvent", "ForkEvent"]
  attr_accessible :user_name, :provider, :uid, :user_id

  belongs_to :user

  def self.create_with_omniauth(auth, user)
    create! do |subscription|
      subscription.provider = auth["provider"]
      subscription.uid = auth["uid"]
      subscription.user_name = auth["info"]["nickname"]
      subscription.user_id = user.id
    end
  end

  def self.get_all_new_github_events
    github_subscriptions.each do |g_subscription|
      g_subscription.get_new_github_events
    end
    self.delay(:run_at => SUBSCRIPTION_FREQ.seconds.from_now).get_all_new_github_events
  end

  def get_new_github_events
    new_events = []
    i = 0
    while true do
      event = github_events[i]
      if event.created_at > (Time.now - SUBSCRIPTION_FREQ)
        new_events << event
      else
        break
      end
      i += 1
    end
    new_events.each do |new_event|
      g = GithubEvent.create(subscription_id: self.id,
                       repo: new_event.repo.name,
                       created_at: new_tweet.created_at,
                       poster_id: self.user_id,
                       event_type: new_event.type
                      )
    end
  end

  def github_events
    events = Octokit.user_events(self.user_name).map do |event|
      event if EVENT_LIST.include?(event.type)
    end
    events
  end

  def self.github_subscriptions
    Subscription.where(provider: "github")
  end
end
