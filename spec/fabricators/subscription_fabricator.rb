Fabricator(:subscription) do
  provider { ["twitter","github"].sample }
  uid      { 11111111111111 }
  user_name { Faker::Name.first_name }
  user_id  { Fabricate(:user).id }
end
