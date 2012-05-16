desc "Kick off Tweet getter every 5 minutes"
task "subscriptions:poll" => :environment do
  Subscription.get_all_new_tweets
  Subscription.get_all_new_github_events
end

