json.accounts @accounts do |json, account|
  json.nickname account.nickname
  json.last_status_id account.last_status_id
  json.user_id account.user_id
end
