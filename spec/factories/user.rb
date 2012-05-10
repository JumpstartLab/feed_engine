FactoryGirl.define do
  factory :user do
    display_name "TestUser"
    email "user@badger.com"
    password "password"
    password_confirmation "password"
  end
end
