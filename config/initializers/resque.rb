require 'resque/server'
require 'resque'
Resque.redis = 'localhost:6379:1/myns'