u1 = User.create!(email: "foo@bar.com", password: "hungry", password_confirmation: "hungry", display_name: "Foo")

p1 = u1.posts.create!(type: "TextPost", content: "Sample Textpost")
p2 = u1.posts.create!(type: "ImagePost", content: "http://www.example.com/example.png")
p3 = u1.posts.create!(type: "LinkPost", content: "http://www.example.com")

u2 = User.create!(email: "sample@example.com", password: "hungry", password_confirmation: "hungry", display_name: "GenericJoe")

p4 = u2.posts.create!(type: "TextPost", content: "Sample Textpost Second")
p5 = u2.posts.create!(type: "ImagePost", content: "http://www.second.com/example.png")
p6 = u2.posts.create!(type: "LinkPost", content: "http://www.second.com")

u3 = User.create!(email: "phantom@example.com", password: "hungry", password_confirmation: "hungry", display_name: "HypotheticalJoe")
  20.times do |i|
    u3.text_posts.create!(content: "Hypothetical Joe, blathering again.")
  end
