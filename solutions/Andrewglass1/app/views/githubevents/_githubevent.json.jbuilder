json.(githubevent, :id, :content, :post_time, :handle)
json.type "githubevent"
json.post_time time_ago_in_words(githubevent.post_time)
json.handle githubevent.handle