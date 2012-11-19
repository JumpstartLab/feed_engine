json.(subscription, :feed_id)
json.feed_name Feed.find(subscription.feed_id).name
