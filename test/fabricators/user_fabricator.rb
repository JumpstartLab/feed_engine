Fabricator(:user, class_name: User) do
  email                 { "#{Faker::Name.first_name}#{sequence}@jumpstartlab.com" }
  display_name          { "#{Faker::Name.first_name}#{sequence}" }
  password              { "tester" }
end

Fabricator(:jeff, class_name: User) do
  email                 { "jeff@jumpstartlab.com" }
  display_name          { "j3" }
  password              { "tester" }
end
