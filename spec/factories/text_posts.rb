# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :text_post do
    text { Faker::Lorem.sentence(20) }
  end
end
