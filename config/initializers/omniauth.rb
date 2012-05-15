Rails.application.config.middleware.use OmniAuth::Builder do
    if Rails.env.production?
      provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    else
      provider :twitter, TWITTER_KEY, TWITTER_SECRET
    end
end
