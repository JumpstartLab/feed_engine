class Point < ActiveRecord::Base
  attr_accessible :pointable_id, :user_id, :pointable, :user

  belongs_to :user
  belongs_to :pointable, :polymorphic => true

  validates_presence_of :pointable_id, :user_id
  validates_uniqueness_of :pointable_id, :scope => [:user_id]
end
