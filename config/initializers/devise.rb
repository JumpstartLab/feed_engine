Devise.setup do |config|
  config.mailer_sender = "horace.badger@gmail.com"

  config.apply_schema = false

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]

  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true

  config.use_salt_as_remember_token = true

  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  if Rails.env.production? 
    TWITTER_KEY = ENV["TWITTER_KEY"]
    TWITTER_SECRET = ENV["TWITTER_SECRET"]
    GITHUB_KEY = ENV["GITHUB_KEY"]
    GITHUB_SECRET = ENV["GITHUB_SECRET"]
    INSTAGRAM_KEY = ENV["INSTAGRAM_KEY"]
    INSTAGRAM_SECRET = ENV["INSTAGRAM_SECRET"]

  else
    TWITTER_KEY = ENV["TWITTER_DEV_KEY"]
    TWITTER_SECRET = ENV["TWITTER_DEV_SECRET"]
    GITHUB_KEY = ENV["GITHUB_DEV_KEY"]
    GITHUB_SECRET = ENV["GITHUB_DEV_SECRET"]
    INSTAGRAM_KEY = ENV["INSTAGRAM_DEV_KEY"]
    INSTAGRAM_SECRET = ENV["INSTAGRAM_SECRET"]
  end

  config.omniauth :twitter, TWITTER_KEY, TWITTER_SECRET, :scope => "users"
  config.omniauth :github, GITHUB_KEY, GITHUB_SECRET, :scope => "users"
  config.omnuayth :instagram, INSTAGRAM_KEY, INSTAGRAM_SECRET :scope => "users"
end
