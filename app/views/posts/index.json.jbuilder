json.posts @posts do |json, post|
  json.partial! post[0]
  json.id post[1]
end