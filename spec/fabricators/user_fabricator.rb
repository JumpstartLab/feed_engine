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
  display_name 'display_name'
  email Faker::Internet.email
  password 'hungry'
end
