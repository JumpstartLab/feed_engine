json.(tweet, :id, :content, :tweet_time)
json.type "tweet"
json.created_at time_ago_in_words(tweet.tweet_time)