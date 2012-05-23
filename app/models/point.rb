class Point < ActiveRecord::Base
  attr_accessible :post_id, :user_id
  belongs_to :post
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => [:post_id]
end
