Rails.application.config.middleware.use OmniAuth::Builder do
    if Rails.env.production?
      provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
      provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
    else
      provider :twitter, TWITTER_KEY, TWITTER_SECRET
      provider :github, GITHUB_KEY, GITHUB_SECRET
    end
end
