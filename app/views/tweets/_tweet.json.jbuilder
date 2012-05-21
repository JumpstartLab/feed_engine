json.(tweet, :id, :content, :tweet_time, :handle)
json.type "tweet"
json.tweet_time time_ago_in_words(tweet.tweet_time)
json.handle tweet.handle