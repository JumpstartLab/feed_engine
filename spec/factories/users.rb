FactoryGirl.define do
  factory :user do
    sequence(:display_name) { |n| "displayname#{n}"}
    sequence(:email) { |n| "email#{n}@example.com"}
    password "hungry"
  end

  factory :user_with_growls, parent: :user do
    after_create do |user, evaluator|
      FactoryGirl.create(:link, user: user)
      FactoryGirl.create(:image, user: user)
      FactoryGirl.create(:message, user:user)
    end
  end
end