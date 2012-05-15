require 'resque_scheduler'

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
Resque.schedule = YAML.load_file('config/resque_schedule.yml')