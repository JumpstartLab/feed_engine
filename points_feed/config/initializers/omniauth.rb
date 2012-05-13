Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'AJ6A08DwICnc7HOC8PPPww', '3onFLtbQIqIZlHh0MzoKIuNcQb2HQR4Z1D0r3C6MHA'

  Twitter.configure do |config|
    config.consumer_key = "AJ6A08DwICnc7HOC8PPPww"
    config.consumer_secret = "3onFLtbQIqIZlHh0MzoKIuNcQb2HQR4Z1D0r3C6MHA"
    config.oauth_token = "47346030-OHMQBz2rPUTUUXNiooXvHIYR6FnkyEtd6d1ZYqiyo"
    config.oauth_token_secret = "TisbxOM05NYBBAHH972ZHlmdUT6e9M0oM2hsyvd2o8"
  end
end