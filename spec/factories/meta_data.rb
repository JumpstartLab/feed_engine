# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meta_datum, :class => 'MetaData' do
    title "MyString"
    description "MyString"
    thumbnail_url "MyString"
  end
end
