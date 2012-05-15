task :cron => :environment do
  puts "Fetching tweets"
  BackgroundWorker.import_from_twitter
  puts "Fetched tweets"
end