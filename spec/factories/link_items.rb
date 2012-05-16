# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link_item do
    url "http://myurl.com"
    comment "MyText"
    user
  end
end
