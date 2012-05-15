class Tweet < ActiveRecord::Base
  attr_accessible :body, :subscription_id, :poster_id, :created_at

  belongs_to :subscription

  def subscription
    Subscription.find(subscription_id)
  end

end
