json.(githubevent, :id, :content, :event_time, :handle)
json.type "githubevent"
json.event_time time_ago_in_words(githubevent.event_time)
json.handle githubevent.handle