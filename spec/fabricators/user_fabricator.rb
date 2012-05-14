# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  display_name    :string(255)
#

Fabricator(:user) do
  display_name { Faker::Lorem.words(2).join('-') }
  email { Faker::Internet.email }
  password 'hungry'
end
