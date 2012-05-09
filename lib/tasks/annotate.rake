begin
  require 'annotate/tasks'

  # Annotation settings
  ENV['position_in_class']   = "before"
  ENV['position_in_fixture'] = "before"
  ENV['show_indexes']        = "true"
  ENV['include_version']     = "false"
  ENV['exclude_tests']       = "true"
  ENV['exclude_fixtures']    = "true"
  ENV['skip_on_db_migrate']  = "false"
rescue Exception => exception
end
