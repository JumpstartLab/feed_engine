# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :twitter_post do
    twitter_id 1
    text "MyString"
    published_at "2012-05-15 17:36:24"
  end
end
