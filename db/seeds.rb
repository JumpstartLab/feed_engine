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


user.growls << FactoryGirl.create(:image)
user.growls << FactoryGirl.create(:link)
user.growls << FactoryGirl.create(:message)
user.growls << FactoryGirl.create(:message)
user.growls << FactoryGirl.create(:link)
user.growls << FactoryGirl.create(:image)

user = User.create(email: 'mikesilvis@gmail.com',
                   password: 'hungry',
                   display_name: 'mikesilvis')
user.update_attribute("authentication_token", "HUNGRLR")

user.growls << FactoryGirl.create(:image)
user.growls << FactoryGirl.create(:link)
user.growls << FactoryGirl.create(:message)
user.growls << FactoryGirl.create(:message)
user.growls << FactoryGirl.create(:link)
user.growls << FactoryGirl.create(:image)