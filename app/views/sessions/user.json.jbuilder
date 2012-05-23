if @user
  json.(@user, :email, :display_name, :subdomain)
end