Fabricator(:image) do
  description  Faker::Lorem.paragraph(word_count = 3)
  url          "http://image.gsfc.nasa.gov/image/image_launch_a5.jpg"
  poster_id    1
end
