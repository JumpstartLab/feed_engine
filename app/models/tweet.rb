class Tweet < ActiveRecord::Base
  include Postable
  attr_accessible :body, :subscription_id, :created_at

  belongs_to :subscription

  def subscription
    Subscription.find(subscription_id)
  end

end
