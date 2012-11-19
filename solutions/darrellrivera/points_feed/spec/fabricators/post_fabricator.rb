Fabricator(:text_post) do
  type "TextPost"
  content { Faker::Lorem.words(10) }
end

Fabricator(:link_post) do
  type "LinkPost"
  content { "http://google.com" }
end

Fabricator(:image_post) do
  type "ImagePost"
  content { "http://google.com/logo.png" }
end