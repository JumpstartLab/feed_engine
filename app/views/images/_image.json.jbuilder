json.(image, :id, :content, :comment)
json.id image.post.id
json.type "image"
json.created_at time_ago_in_words(image.created_at)