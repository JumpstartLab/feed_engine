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

# For tweets on a user who has authorized twitter
class Tweet < ActiveRecord::Base
  include Postable
  include Service

  attr_accessible :body

end
