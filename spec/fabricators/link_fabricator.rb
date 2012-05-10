Fabricator(:link) do
  description  Faker::Lorem.paragraph(word_count = 3)
  url          "http://espn.com"
  poster_id    1
end
