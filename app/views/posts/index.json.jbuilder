json.posts @posts do |json, post|
  json.partial! post
end
json.page_count @page_count