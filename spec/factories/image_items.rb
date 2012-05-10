# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image_item do
    url "http://hungryacademy.com/images/beast.png"
    comment "MyString"
    user_id 1
  end
end
