Fabricator(:image_post, class_name: Image) do
  content   { IMAGE_URLS[rand(0...IMAGE_URLS.count)] }
  comment   { Faker::Lorem.sentences(3).join }
  user_id   { Fabricate(:user).id }
end