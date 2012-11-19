json.users @users do |json, user|
  json.id user.id
  json.twitter_token user.twitter.token
  json.twitter_secret user.twitter.secret
  json.twitter_id user.last_twitter_id
end