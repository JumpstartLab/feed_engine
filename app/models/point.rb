class Point < ActiveRecord::Base
  attr_accessible :streamable_id, :user_id, :streamable, :user

  belongs_to :user
  belongs_to :streamable, :polymorphic => true

  validates_presence_of :streamable_id, :user_id
  validates_uniqueness_of :streamable_id, :scope => [:user_id]
end
