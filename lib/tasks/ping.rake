desc "pings my domain every x mimnutes"
task :pings do
  require 'net/http'
  require 'uri'
  Net::HTTP.get URI("http://hungrlr.com")
end