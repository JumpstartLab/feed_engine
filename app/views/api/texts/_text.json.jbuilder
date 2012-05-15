json.(text, :id, :content)
json.type "text"
json.created_at time_ago_in_words(text.created_at)
