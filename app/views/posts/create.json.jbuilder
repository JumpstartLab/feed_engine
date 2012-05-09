unless @post.errors.any?
  json.(@post, :id, :content)
else
  json.errors @post.errors.full_messages
  json.status :unprocessable_entity
end