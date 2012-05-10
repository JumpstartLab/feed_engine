u1 = User.create!(email: "foo@bar.com", password: "hungry", password_confirmation: "hungry", display_name: "Foo")

p1 = u1.posts.create!(type: "TextPost", content: "Sample Textpost", title: "SomeText")
p2 = u1.posts.create!(type: "ImagePost", content: "http://www.example.com/example.png", title: "SomeImage")
p3 = u1.posts.create!(type: "LinkPost", content: "http://www.example.com", title: "SomeLink")

u2 = User.create!(email: "sample@example.com", password: "hungry", password_confirmation: "hungry", display_name: "GenericJoe")

p4 = u2.posts.create!(type: "TextPost", content: "Sample Textpost Second", title: "SomeText2")
p5 = u2.posts.create!(type: "ImagePost", content: "http://www.second.com/example.png", title: "SomeImage2")
p6 = u2.posts.create!(type: "LinkPost", content: "http://www.second.com", title: "SomeLink2")

u3 = User.create!(email: "phantom@example.com", password: "hungry", password_confirmation: "hungry", display_name: "HypotheticalJoe")
  20.times do |i|
    u3.text_posts.create!(content: "Hypothetical Joe, blathering again.", title: "HJoe-#{i}")
  end