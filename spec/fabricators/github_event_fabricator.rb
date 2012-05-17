Fabricator(:github_event) do
  subscription_id 1
  repo   { Faker::Name.name }
  event_type {["PushEvent", "ForkEvent", "CreateEvent"].sample}
  poster_id 1
end
