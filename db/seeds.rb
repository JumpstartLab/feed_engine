# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = FactoryGirl.create(:user, :display_name => "testuser",
                         :email => "user@badger.com",
                         :password => "password",
                         :password_confirmation => "password")
50.times do
  FactoryGirl.create(:text_item, :user => user)
end

50.times do
  FactoryGirl.create(:link_item, :user => user)
end

