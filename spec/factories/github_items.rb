# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :github_item do
    event "hello"
    user
    event_id { rand(1..10) }
  end
end
