if Rails.env.production?
  uri = URI.parse(ENV["REDISTOGO_URL"] || "http://superhotfeedengine.com")
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

