# == Schema Information
#
# Table name: instapounds
#
#  id              :integer         not null, primary key
#  image_url       :string(255)
#  poster_id       :integer
#  body            :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  subscription_id :integer
#  points          :integer         default(0)
#

Fabricator(:instapound) do
  subscription_id 1
  image_url { "http://travis.com/travis.jpg" }
  body { Faker::Lorem.words(5).join(" ") }
  poster_id 1
end
