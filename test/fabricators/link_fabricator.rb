Fabricator(:link_post, class_name: Link) do
  content   { LINK_URLS[rand(0...IMAGE_URLS.count)] }
  comment   { Faker::Lorem.sentences(3).join }
  user_id   { Fabricate(:user).id }
end