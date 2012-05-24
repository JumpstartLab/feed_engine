json.(image, :id, :content, :comment)
json.type "image"
json.created_at time_ago_in_words(image.created_at)