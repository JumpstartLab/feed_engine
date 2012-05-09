# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :text_item do
    body "MyString"
    user_id 1
  end
end
