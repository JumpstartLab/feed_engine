# == Schema Information
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  body       :text
#  poster_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

Fabricator(:message) do
  poster_id { Fabricate(:user).id }
  body      { Faker::Lorem.words(10).join(' ') }
end
