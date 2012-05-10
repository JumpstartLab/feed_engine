# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FeedEngine::Application.initialize!

# Use logic less views
#Slim::Engine.set_default_options :sections => true
