FactoryGirl.define do
  factory :user do
    sequence(:display_name) { |n| "displayname#{n}"}
    sequence(:email) { |n| "email#{n}@example.com"}
    password "hungry"
  end

  factory :user_with_growls, parent: :user do
    after_create do |user, evaluator|
      FactoryGirl.create(:instagram, user: user)
      FactoryGirl.create(:github, user: user)
      FactoryGirl.create(:tweet, user: user)
      FactoryGirl.create(:link, user: user)
      FactoryGirl.create(:image, user: user)
      FactoryGirl.create(:message, user:user)
      FactoryGirl.create(:video, user:user)

    end
  end

  factory :user_with_twitter_account, parent: :user do
    after_create do |user, evaluator|
      authentication = FactoryGirl.create(:authentication, user: user)
      FactoryGirl.create(:twitter_account, authentication: authentication)
    end
  end
end