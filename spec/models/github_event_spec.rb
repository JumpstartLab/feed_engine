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
#  points          :integer         default(0)
#

require 'spec_helper'

describe GithubEvent do
  pending "add some examples to (or delete) #{__FILE__}"
end
