json.(tweet, :id, :content, :post_time, :handle)
json.type "tweet"
json.post_time time_ago_in_words(tweet.post_time)
json.handle tweet.handle