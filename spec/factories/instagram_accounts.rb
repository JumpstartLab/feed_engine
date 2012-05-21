# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :instagram_account do
    uid "MyString"
    nickname "MyString"
    image "MyString"
    last_status_id "MyString"
    datetime "MyString"
  end
end
