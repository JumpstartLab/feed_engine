json.(link, :id, :content, :comment)
json.type "link"
json.created_at time_ago_in_words(link.created_at)
json.points instagramimage.points.size
json.post_id link.post.id
json.addpoint "/posts/#{link.post.id}/points"
json.allpoints link.points