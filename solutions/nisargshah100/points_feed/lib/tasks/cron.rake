task :cron => :environment do
  puts "Fetching tweets"
  BackgroundWorker.import_from_twitter
  puts "Fetched tweets"

  puts "Fetching github stuff"
  BackgroundWorker.import_from_github
  puts "Fetched Github!"
end