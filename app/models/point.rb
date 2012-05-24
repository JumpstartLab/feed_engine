# == Schema Information
#
# Table name: points
#
#  id          :integer         not null, primary key
#  post_id     :integer
#  receiver_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  giver_id    :integer
#  added       :boolean
#

class Point < ActiveRecord::Base
  attr_accessible :post_id, :receiver_id, :giver_id
  belongs_to :post

  validates_uniqueness_of :giver_id, :scope => [:post_id]
end
