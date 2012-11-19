json.subscriptions @subscriptions do |json, subscription|
  json.partial! subscription
end