require 'resque'

if Rails.env.production?
  redis_url = 'redis://redistogo:36b7efb20d6d3647c3478b8c868453b9@panga.redistogo.com:9459/'
else
  redis_url = 'localhost:6379'
end

uri = URI.parse(redis_url)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = REDIS
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }