# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all

user1 = User.create(email: "michael.verdi@livingsocial.com", password: "hungry", display_name: "Verdi327", full_name: "Michael Verdi")
user2 = User.create(email: "charles.strahan@livingsocial.com", password: "hungry", display_name: "Strahan", full_name: "Charles Strahan")
user3 = User.create(email: "mike.chlipala@livingsocial.com", password: "hungry", display_name: "Chlipala", full_name: "Mike Chlipala")
user4 = User.create(email: "tom.kiefhaber@livingsocial.com", password: "hungry", display_name: "Kiefhaber", full_name: "Tom Kiefhaber")

#user 1
user1.text_posts.create(title: "First Post", body: "Hello World!")
user1.image_posts.create(remote_image_url: "http://veganvsvegetarian.info/
                                            wp-content/uploads/2011/
                                            11/smoothies.jpg", description: "Cheers to Life!")
user1.link_posts.create(url: "http://techcrunch.com/2012/05/13/hold
                            -the-phone-how-the-future-of-web-
                            advertising-is-linked-to-the-call/", description: "Very Interesting")
#user 2
user1.text_posts.create(title: "First Post", body: "Hello World!")
user2.image_posts.create(remote_image_url: "http://veganvsvegetarian.info/
                                            wp-content/uploads/2011/
                                            11/smoothies.jpg", description: "Cheers to Life!")
user2.link_posts.create(url: "http://techcrunch.com/2012/05/13/hold
                            -the-phone-how-the-future-of-web-
                            advertising-is-linked-to-the-call/", description: "Very Interesting")
#user 3
user1.text_posts.create(title: "First Post", body: "Hello World!")
user3.image_posts.create(remote_image_url: "http://veganvsvegetarian.info/
                                            wp-content/uploads/2011/
                                            11/smoothies.jpg", description: "Cheers to Life!")
user3.link_posts.create(url: "http://techcrunch.com/2012/05/13/hold
                            -the-phone-how-the-future-of-web-
                            advertising-is-linked-to-the-call/", description: "Very Interesting")
#user 4
user1.text_posts.create(title: "First Post", body: "Hello World!")
user4.image_posts.create(remote_image_url: "http://veganvsvegetarian.info/
                                            wp-content/uploads/2011/
                                            11/smoothies.jpg", description: "Cheers to Life!")
user4.link_posts.create(url: "http://techcrunch.com/2012/05/13/hold
                            -the-phone-how-the-future-of-web-
                            advertising-is-linked-to-the-call/", description: "Very Interesting")


