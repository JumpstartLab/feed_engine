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
#

require 'spec_helper'

describe Tweet do
  pending "add some examples to (or delete) #{__FILE__}"
end
