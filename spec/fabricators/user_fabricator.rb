Fabricator(:user) do
  display_name 'display_name'
  email Faker::Internet.email
  password 'hungry'
end
