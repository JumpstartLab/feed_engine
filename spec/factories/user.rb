FactoryGirl.define do
  factory :user do
    display_name "testuser"
    email "user@badger.com"
    password "password"
    password_confirmation "password"
  end
end
