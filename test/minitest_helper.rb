require 'simplecov'
SimpleCov.start 'rails' do
  add_filter "/test/"
end

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "minitest/autorun"
require "capybara/rails"
require 'rails/test_help'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("test/support/**/*.rb")].each {|f| require f}

Turn.config.format = :outline

include Sorcery::TestHelpers::Rails
include PostTestHelpers