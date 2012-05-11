# == Schema Information
#
# Table name: images
#
#  id          :integer         not null, primary key
#  description :text
#  url         :text
#  poster_id   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

Fabricator(:image) do
  description  { Faker::Lorem.paragraph(word_count = 3) }
  url          { Faker::Internet.url + '.jpg' }
end
