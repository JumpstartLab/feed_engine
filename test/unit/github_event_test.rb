require 'minitest_helper'

describe Githubevent do
  it "creates a Githubevent record on create" do
    time = 2.days.ago
    event = Githubevent.create(:user_id => 1, 
      :content => "Omar77 created a new repo mother_of_feed_engine",
      :action => "CreateEvent",
      :event_id => "123456", 
      :handle => "Omar77",
      :repo => "mother_of_feed_engine",
      :post_time => time)
    assert_equal event.valid?, true
    assert_equal event.user_id, 1
    assert_equal event.content, "Omar77 created a new repo mother_of_feed_engine"
    assert_equal event.action, "CreateEvent"
    assert_equal event.event_id, "123456"
    assert_equal event.handle, "Omar77"
    assert_equal event.repo, "mother_of_feed_engine"
    assert_equal event.post_time, time
  end
end
