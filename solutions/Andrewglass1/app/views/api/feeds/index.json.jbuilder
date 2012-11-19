json.(user, :id, :content, :comment)
json.type "link"
json.created_at time_ago_in_words(link.created_at)