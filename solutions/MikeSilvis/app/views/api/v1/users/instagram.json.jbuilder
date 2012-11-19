json.accounts @accounts do |json, account|
  json.user_id account.user_id
  json.last_status_id account.last_status_id
  json.instagram_id account.uid
  json.token account.authentication.token
end
