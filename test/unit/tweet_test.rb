require 'minitest_helper'

describe Tweet do
  it "creates a Tweet record on create" do
    time = 3.days.ago
    tweet = Tweet.create(:user_id => 1, 
      :content => "Ima tweet!",
      :source_id => "123456", 
      :handle => "@Omar", 
      :tweet_time => time)
    assert_equal tweet.valid?, true
    assert_equal tweet.user_id, 1
    assert_equal tweet.content, "Ima tweet!"
    assert_equal tweet.source_id, "123456"
    assert_equal tweet.handle, "@Omar"
    assert_equal tweet.tweet_time, time
  end
end
