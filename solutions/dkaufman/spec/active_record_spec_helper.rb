require 'active_record'

connection_info = YAML.load(File.open("config/database.yml"))["test"]

ActiveRecord::Base.establish_connection(connection_info)


