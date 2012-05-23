json.(githubevent, :id, :content, :post_time, :handle)
json.type "githubevent"
json.post_time time_ago_in_words(githubevent.post_time)
json.handle githubevent.handle
json.repo githubevent.repo
json.points githubevent.points.size
json.post_id githubevent.post.id
json.addpoint "/posts/#{githubevent.post.id}/points"
json.allpoints githubevent.points
