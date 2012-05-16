Fabricator(:tweet) do
  subscription_id 1
  body { Faker::Lorem.words(5) }
  poster_id 1
end
