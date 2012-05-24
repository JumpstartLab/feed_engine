require 'resque'

if Rails.env.production?
  redis_url = 'redis://redistogo:ea9756f0736ac05039878f71090de676@scat.redistogo.com:9067/'
else
  redis_url = 'localhost:6379'
end

uri = URI.parse(redis_url)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = REDIS
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }