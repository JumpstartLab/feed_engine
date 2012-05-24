require 'resque'

if Rails.env.production?
  uri = URI.parse(ENV["REDISTOGO_URL"] || "http://superhotfeedengine.com")
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  Resque.redis = 'localhost:6379:1/myns'
end
