json.subscriptions @subscriptions do |json, subscription|
  json.user_display_name subscription.user.display_name
  json.user_id subscription.user_id
  json.user_slug subscription.user.slug
  json.subscriber_display_name subscription.subscriber.display_name
  json.subscriber_id subscription.subscriber_id
  json.subscriber_slug subscription.subscriber.slug
  json.last_status_id subscription.last_status_id
end