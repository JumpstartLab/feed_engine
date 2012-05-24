desc "Kick off Subscription getter every 5 minutes"
task "subscriptions:poll" => :environment do
  Subscription.all.each { |sub| sub.get_new_service_posts }
end

