FactoryGirl.define do

  factory :image do
    link "http://www.justanimal.org/images/gorilla-10.jpg"
  end
  
  factory :user do
    sequence(:username) { |n| "username#{n}"}
    sequence(:email) { |n| "email#{n}@example.com"}
    password "hungry"
  end

end