class GithubEvent < ActiveRecord::Base
  include Postable
  attr_accessible :repo, :event_type, :subscription_id, :created_at

  belongs_to :subscription

  def subscription
    Subscription.find(subscription_id)
  end

end
