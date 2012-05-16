Fabricator(:tweet_post, :class_name => Tweet) do
  user_id     { Fabricate(:user).id }
  content     "Ima tweet!"
  source_id   { Time.now.to_i.to_s }
  handle      "@Omar"
  tweet_time  { 2.hours.ago }
end