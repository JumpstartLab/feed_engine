task :mailgun => :environment do
  data = Multimap.new
  data[:priority] = 1
  data[:description] = "PointsFeed Route"
  data[:expression] = "match_recipient('.*@pointsfeedin.mailgun.org')"
  data[:action] = "forward('http://pointsfeed.in/api/mail')"
  data[:action] = "stop()"
  RestClient.post "https://api:key-1ncwhoe22tfykxvxsz4gfizx5f536lh2"\
  "@api.mailgun.net/v2/routes", data
end