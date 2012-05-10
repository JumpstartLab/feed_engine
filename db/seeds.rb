# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = FactoryGirl.create(:user)
50.times do
  user.text_items << FactoryGirl.create(:text_item)
end

50.times do
  user.link_items << FactoryGirl.create(:link_item)
end

