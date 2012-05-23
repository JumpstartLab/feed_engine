# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Fabricate(:user_with_posts, :email => 'jonanscheffler@gmail.com', :display_name => '1337807')
Fabricate(:user_with_posts, :email => 'elise.worthy@livingsocial.com', :display_name => 'elise')
Fabricate(:user_with_posts, :email => 'andrew.thal@livingsocial.com', :display_name => 'athal7')
Fabricate(:user_with_posts, :email => 'travis.valentine@livingsocial.com', :display_name => 'travis')
