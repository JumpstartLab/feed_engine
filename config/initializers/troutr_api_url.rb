
if Rails.env.production?
  TROUTR_API_URL = "http://api.polutropos.com"
else
  TROUTR_API_URL = "http://api.lvh.me:3000"
end
