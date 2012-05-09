# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link_item do
    url "http://myurl.com"
    comment "MyText"
    user_id 1
  end
end
