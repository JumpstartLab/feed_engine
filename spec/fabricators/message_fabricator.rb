Fabricator(:message) do
  body  Faker::Lorem.paragraph(word_count = 10)
  poster_id 1
end
