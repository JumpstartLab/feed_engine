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
  description  Faker::Lorem.paragraph(word_count = 3)
  url          "http://image.gsfc.nasa.gov/image/image_launch_a5.jpg"
  poster_id    1
end
