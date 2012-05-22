ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "minitest/autorun"
require "capybara/rails"
require 'rails/test_help'

Turn.config.format = :outline

include Sorcery::TestHelpers::Rails