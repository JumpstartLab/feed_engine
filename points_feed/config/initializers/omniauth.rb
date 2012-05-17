Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'AJ6A08DwICnc7HOC8PPPww', '3onFLtbQIqIZlHh0MzoKIuNcQb2HQR4Z1D0r3C6MHA'
  provider :github, 'a7b4784e6089f033bbc0', '26eebe36d42cad2fe80d0bae93e15b3862ee4996'
  provider :instagram, '25e04f4e2bda41fea6e629f724e2066f', '31f053ff5d7a427f8ba993d871118541'

  Twitter.configure do |config|
    config.consumer_key = "AJ6A08DwICnc7HOC8PPPww"
    config.consumer_secret = "3onFLtbQIqIZlHh0MzoKIuNcQb2HQR4Z1D0r3C6MHA"
  end
end