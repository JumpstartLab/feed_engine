FactoryGirl.define do

  factory :image do
    link "http://mikesawesome.com/image.png"
  end
  factory :user do
    sequence(:username) { |n| "username#{n}"}
    sequence(:email) { |n| "email#{n}@example.com"}
    password "hungry"
  end

end