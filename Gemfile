source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'jquery-rails'
gem 'slim'
gem 'simple_form'
gem 'dynamic_form'
gem 'resque'
gem 'decent_exposure'
gem 'squeel'
gem 'devise'
gem 'bootstrap-sass', '~> 2.0.2'
gem 'carrierwave'
gem 'rmagick'
gem 'fog'
gem 'mustache'
gem 'exceptional'
gem 'rabl'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'twitter'
gem 'octokit'
gem 'delayed_job_active_record'
gem 'daemon'
gem 'wicked'
gem 'feed_engine_api',
    :git => "git://github.com/cstrahan/feed_engine_api.git",
    :tag => "v0.0.4"

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  # Just for erb->slim
  gem 'haml'
  gem 'haml2slim'
  gem 'hpricot'

  gem 'rake'
  gem 'faker'
  gem 'sqlite3'
  gem 'guard-cucumber'
  gem 'guard-rspec'
  gem 'cucumber-rails', :require => false
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'redis-store', '~>1.0.0'
  #gem 'rack-perftools_profiler', :require => 'rack/perftools_profiler'

  # Chainsaw logging
  gem 'dnssd'
  gem 'log4r'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
