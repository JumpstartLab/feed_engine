# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer         not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  user_name  :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

Fabricator(:subscription) do
  provider { ["twitter","github"].sample }
  uid      { 11111111111111 }
  user_name { Faker::Name.first_name }
  user_id  { Fabricate(:user).id }
end
