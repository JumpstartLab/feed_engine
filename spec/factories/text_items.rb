# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :text_item do
    body { Faker::Lorem.paragraph(sentence_count = 2) }
    user
  end
end
