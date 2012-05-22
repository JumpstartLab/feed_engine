desc "Kick off Tweet getter every 5 minutes"
task "subscriptions:poll" => :environment do
  Subscription.get_all_new_service_posts
end

