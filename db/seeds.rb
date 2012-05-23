# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'ed.weng@livingsocial.com',
                   password: 'hungry',
                   display_name: 'wengzilla')

user.update_attribute("authentication_token", "HUNGRLR")
# FactoryGirl.create(:image, user: user)
# FactoryGirl.create(:link, user: user)
# FactoryGirl.create(:message, user: user)
# FactoryGirl.create(:message, user: user)
# FactoryGirl.create(:link, user: user)
# FactoryGirl.create(:image, user: user)

user = User.create(email: 'mikesilvis@gmail.com',
                   password: 'hungry',
                   display_name: 'mikesilvis')
user.update_attribute("authentication_token", "HUNGRLRx2")

# FactoryGirl.create(:tweet, user: user)
# FactoryGirl.create(:image, user: user)
# FactoryGirl.create(:link, user: user)
# FactoryGirl.create(:message, user: user)
# FactoryGirl.create(:message, user: user)
# FactoryGirl.create(:link, user: user)
# FactoryGirl.create(:image, user: user)