json.(text, :id, :content)
json.type "text"
json.created_at time_ago_in_words(text.created_at)
json.points text.points.size
json.post_id text.post.id
json.addpoint "/posts/#{text.post.id}/points"
json.allpoints text.points