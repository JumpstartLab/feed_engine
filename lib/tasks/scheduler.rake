desc "This task is called by the Heroku scheduler add-on"
ENV["REDISTOGO_URL"] = 'redis://redistogo:6b3900eac2b9d03ecf69a503a771d644@panga.redistogo.com:9579/'
require './app/jobs/pull_twitter_feed.rb'
require './config/initializers/redis.rb'
task :get_tweets do
  Resque.enqueue(PullTwitterFeed)
  sleep(300)
  Resque.enqueue(PullTwitterFeed)
end