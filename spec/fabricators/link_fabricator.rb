# == Schema Information
#
# Table name: links
#
#  id          :integer         not null, primary key
#  description :text
#  url         :text
#  poster_id   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

Fabricator(:link) do
  description  Faker::Lorem.paragraph(word_count = 3)
  url          "http://espn.com"
  poster_id    1
end
