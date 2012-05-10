Fabricator(:message) do
  body  Faker::Lorem.words(15)
  poster_id 1
end
