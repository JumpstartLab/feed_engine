json.(image, :id, :content, :comment)
json.type "image"
json.created_at time_ago_in_words(image.created_at)
json.points image.points.size
json.post_id image.post.id
json.addpoint "/posts/#{image.post.id}/points"
json.allpoints image.points