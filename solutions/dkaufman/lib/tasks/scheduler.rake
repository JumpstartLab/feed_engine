desc "Heroku runs this task every 10 minutes to pull outside data for our feed"
ENV["REDISTOGO_URL"] = 'redis://redistogo:6b3900eac2b9d03ecf69a503a771d644@panga.redistogo.com:9579/'
ENV["QUEUE"] = "*"
require './app/jobs/pull_twitter_feed.rb'
require './app/jobs/pull_github_feed.rb'
require './app/jobs/pull_instagram_feed.rb'
require './app/jobs/refeed.rb'
require './config/initializers/redis.rb'
task "jobs:work" => "resque:work"

task :pull_feeds do
  Resque.enqueue(PullTwitterFeed)
  Resque.enqueue(PullGithubFeed)
  Resque.enqueue(PullInstagramFeed)
  Resque.enqueue(Refeed)
  sleep(300)
  Resque.enqueue(PullTwitterFeed)
  Resque.enqueue(PullGithubFeed)
  Resque.enqueue(PullInstagramFeed)
  Resque.enqueue(Refeed)
end
