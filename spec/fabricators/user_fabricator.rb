Fabricator(:user) do
  display_name 'Display Name'
  email Faker::Internet.email
  password 'hungry'
end
