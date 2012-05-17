module Service
  def self.included(base)
    base.instance_eval do
      attr_accessible :subscription_id, :created_at
      belongs_to :subscription
    end
  end

  def subscription
    Subscription.find(subscription_id)
  end
end
