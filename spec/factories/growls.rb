FactoryGirl.define do

  factory :image do
    link "http://www.justanimal.org/images/gorilla-10.jpg"
    comment Faker::Lorem.sentences(1).join
  end

  factory :message do
   comment Faker::Lorem.sentences(1).join
  end

  factory :link do
   link "http://www.google.com"
   comment Faker::Lorem.sentences(1).join
  end

end
