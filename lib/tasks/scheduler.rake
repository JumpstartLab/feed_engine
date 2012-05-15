desc "This task is called by the Heroku scheduler add-on"
task :get_tweets do
  Resque.enqueue(PullTwitterFeed)
  sleep(300)
  Resque.enqueue(PullTwitterFeed)
end