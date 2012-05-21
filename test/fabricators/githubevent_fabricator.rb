Fabricator(:githubevent_post, :class_name => Githubevent) do
  user_id     { Fabricate(:user).id }
  content     "Omar77 created a new repo mother_of_feed_engine"
  action      "CreateEvent"
  event_id    { Time.now.to_i.to_s }
  handle      "Omar77"
  event_time  { 2.hours.ago }
  repo        "mother_of_feed_engine"
end