json.name @user.display_name
json.id @user.id
json.private @user.private
json.link @user.api_link(request)
json.items do |json|
  json.most_recent @recent_growls do |json, growl|
    json.partial! growl
  end
end
json.web_url @user.web_url(request)
