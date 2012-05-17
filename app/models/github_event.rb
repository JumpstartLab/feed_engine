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

class GithubEvent < ActiveRecord::Base
  include Postable
  include Service
  attr_accessible :repo, :event_type

end
