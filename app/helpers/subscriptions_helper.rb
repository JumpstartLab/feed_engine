module SubscriptionsHelper
  def current_feed_subscription
    current_user.subscriptions.find_by_followed_user_id(@feed_owner.id)
  end
end
