Fabricator(:subscription) do
  provider { ["twitter","github"].sample }
  uid      { [0..10]*20 }
  user_name { Faker::Name.first_name }
  user_id  { Fabricate(:user).id }
end
