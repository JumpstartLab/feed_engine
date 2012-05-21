unless @user.errors.any?
  json.(@user, :id, :email)
else
  json.errors @user.errors.full_messages
end