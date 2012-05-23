Fabricator(:instagramimage_post, class_name: Instagramimage) do
  content     "TBD"
  caption     "Iman Instagram!"
  source_id   { Time.now.to_i.to_s }
  handle      "Omar"
  post_time   { 2.hours.ago }
end