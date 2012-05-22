# == Schema Information
#
# Table name: points
#
#  id         :integer         not null, primary key
#  post_id    :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Point < ActiveRecord::Base
  attr_accessible :post_id, :user_id
  belongs_to :post

  validates_uniqueness_of :user_id, :scope => [:post_id]
end
