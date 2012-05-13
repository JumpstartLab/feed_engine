json.name @user.display_name
json.id @user.id
json.private @user.private
json.link @user.api_link(request)
json.items do |json|
  json.growls @user.growls
end
json.web_url @user.web_url(request)
