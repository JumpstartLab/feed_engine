Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'AJ6A08DwICnc7HOC8PPPww', '3onFLtbQIqIZlHh0MzoKIuNcQb2HQR4Z1D0r3C6MHA'

  Twitter.configure do |config|
    config.consumer_key = "AJ6A08DwICnc7HOC8PPPww"
    config.consumer_secret = "3onFLtbQIqIZlHh0MzoKIuNcQb2HQR4Z1D0r3C6MHA"
  end
end