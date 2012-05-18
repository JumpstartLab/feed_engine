# == Schema Information
#
# Table name: github_events
#
#  id              :integer         not null, primary key
#  event_type      :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  subscription_id :integer
#  repo            :string(255)
#  poster_id       :integer
#

Fabricator(:github_event) do
  subscription_id 1
  repo   { Faker::Name.name }
  event_type {["PushEvent", "ForkEvent", "CreateEvent"].sample}
  poster_id 1
end
