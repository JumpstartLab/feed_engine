if @user
  json.(@user, :email, :display_name)
end