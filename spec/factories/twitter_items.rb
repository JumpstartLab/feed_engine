# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :twitter_item do
    json_blob "MyText"
    user nil
  end
end
