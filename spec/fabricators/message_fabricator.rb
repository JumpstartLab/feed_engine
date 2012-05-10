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
  body  Faker::Lorem.paragraph(word_count = 10)
  poster_id 1
end
