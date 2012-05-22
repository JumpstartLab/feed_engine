FactoryGirl.define do

  factory :growl do

  end

  factory :image, :parent => :growl do
    type "Image"
    link "http://www.justanimal.org/images/gorilla-10.jpg"
    comment Faker::Lorem.sentences(1).join
  end

  factory :message, :parent => :growl do
    type "Message"
    comment Faker::Lorem.sentences(1).join
  end

  factory :link, :parent => :growl do
    type "Link"
    link "http://www.google.com"
    comment Faker::Lorem.sentences(1).join
  end
  factory :tweet, parent: :growl do
    type "Tweet"
    comment "http://google.com is super awesome. Thanks @mikesilvis"
  end
end
