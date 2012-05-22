if Rails.env.production?
  BASE_URL = "superhotfeedengine.com"
elsif Rails.env.development?
  BASE_URL = "lvh.me:3000"
end

