desc "Kick off Tweet getter every 5 minutes"
task "tweets:poll" => :environment do
  Subscription.get_all_new_tweets
end

Rake::Task['jobs:work'].enhance("tweets:poll")
