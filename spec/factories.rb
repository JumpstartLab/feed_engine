FactoryGirl.define do

  factory :image do
    link "http://www.justanimal.org/images/gorilla-10.jpg"
    comment Faker::Lorem.sentences(1).join
  end

  factory :message do
   comment Faker::Lorem.sentences(1).join
  end

  factory :link do
   link "http://www.google.com"
   comment Faker::Lorem.sentences(1).join
  end

  factory :user do
    sequence(:display_name) { |n| "display_name#{n}"}
    sequence(:email) { |n| "email#{n}@example.com"}
    password "hungry"
  end

  factory :user_with_growls, parent: :user do
    after_create do |user, evaluator|
      FactoryGirl.create(:image, user: user)
      FactoryGirl.create(:message, user:user)
      FactoryGirl.create(:link, user:user)
    end
  end

end
