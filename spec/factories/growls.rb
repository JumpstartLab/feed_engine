FactoryGirl.define do

  factory :growl do

  end

  factory :image, :parent => :growl do
    type "Image"
    link "http://www.justanimal.org/images/gorilla-10.jpg"
    comment "THIS IS AN IMAGE"
  end

  factory :message, :parent => :growl do
    type "Message"
    comment "THIS IS AN MESSAGE"
  end

  factory :link, :parent => :growl do
    type "Link"
    link "http://www.google.com"
    comment "THIS IS AN LINK"
  end

  factory :tweet, parent: :growl do
    type "Tweet"
    comment "http://google.com is super awesome. Thanks @mikesilvis"
  end
  factory :github, parent: :growl do
    type "GithubEvent"
    comment "Merging pull request from Mike"
  end
  factory :instagram, parent: :growl do
    type "InstagramPhoto"
    link "http://s3.amazonaws.com/hungrlr/instagram_photos/photos/000/000/076/medium/open-uri20120522-87808-12fmq3l?1337700237"
    comment "Hello World"
  end
  factory :video, parent: :growl do
    type "Video"
    link "http://www.youtube.com/watch?v=0HVLtYFaYys&feature=g-all-u"
    comment "Hello World"
  end
end
