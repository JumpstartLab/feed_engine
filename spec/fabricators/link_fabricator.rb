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
#  points      :integer         default(0)
#

Fabricator(:link) do
  poster_id    { Fabricate(:user).id }
  description  { Faker::Lorem.words(10).join(' ') }
  url          { Faker::Internet.url }
end
