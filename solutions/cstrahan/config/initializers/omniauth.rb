Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'UpoPl9KlDJJlzVf7poMeFQ', 'GOskrA43L9LM9FWAmzVJ2vjtPTHfEgLKYdubuAK3I'
  provider :github,  '9a96ebb33bbf4de9d366', '06f71bb2e21aeece6bc4b729ad7aa464d50fb56c'
  provider :instagram, 'b496acfa010648c6beb9a4a9ca8dc4ed', '7ee08e58c39b42b5b8eab60723a1b268'
end
