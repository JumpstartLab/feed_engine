# == Schema Information
#
# Table name: tweets
#
#  id              :integer         not null, primary key
#  subscription_id :integer
#  body            :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  poster_id       :integer
#  points          :integer         default(0)
#

Fabricator(:tweet) do
  subscription_id 1
  body { Faker::Lorem.words(5) }
  poster_id 1
end
