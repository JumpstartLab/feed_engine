Dir[Rails.root.join("test/fabricators/*.rb")].each {|f| require f}

User.destroy_all
Text.destroy_all
Image.destroy_all
Link.destroy_all

jeff = Fabricate(:jeff)

10.times { Fabricate(:text_post, user_id: jeff.id) }
10.times { Fabricate(:image_post, user_id: jeff.id) }
10.times { Fabricate(:link_post, user_id: jeff.id) }