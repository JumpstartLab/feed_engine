json.name @user.display_name
json.id @user.id
json.private @user.private
json.link v1_url(@user.display_name, :json)
json.items do |json|
  json.pages @growls.num_pages
  json.first_page
  json.most_recent @recent_growls do |json, growl|
    json.partial! growl
  end
end
json.web_url user_feed_url(subdomain: @user.display_name)
