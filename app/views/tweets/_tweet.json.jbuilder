json.(tweet, :id, :content, :post_time, :handle)
json.type "tweet"
json.post_time time_ago_in_words(tweet.post_time)
json.handle tweet.handle
json.points tweet.points.size
json.post_id tweet.post.id
json.addpoint "/posts/#{tweet.post.id}/points"
json.allpoints tweet.points