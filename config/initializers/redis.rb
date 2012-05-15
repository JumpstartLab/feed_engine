require 'resque'
redis_url = ENV["REDISTOGO_URL"]
uri = URI.parse(redis_url)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = REDIS
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
