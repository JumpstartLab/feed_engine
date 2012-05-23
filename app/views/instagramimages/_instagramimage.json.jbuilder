json.(instagramimage, :id, :content, :post_time, :handle, :caption)
json.type "instagramimage"
json.post_time time_ago_in_words(instagramimage.post_time)
json.handle instagramimage.handle
json.points instagramimage.points.size
json.post_id instagramimage.post.id
json.addpoint "/posts/#{instagramimage.post.id}/points"
json.allpoints instagramimage.points