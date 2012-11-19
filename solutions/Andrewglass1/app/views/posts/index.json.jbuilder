json.posts @posts do |json, post|
  json.partial! post[0]
  json.id post[1]
  json.points Post.find(post[1]).points.size
end