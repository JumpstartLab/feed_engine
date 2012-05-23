FactoryGirl.define do
  factory :user do
    display_name { Faker::Lorem.words(num = 2).join("") }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"

    after_build { |user| user.class.skip_callback(:create, :after, :send_welcome_mail) }
  end
end
