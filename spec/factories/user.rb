FactoryGirl.define do
  factory :user do
    display_name Faker::Name.first_name.downcase
    sequence(:email) { |n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end
end
