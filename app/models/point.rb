class Point < ActiveRecord::Base
  attr_accessible :pointable_id, :user_id, :pointable_type, :user, :pointable

  belongs_to :user
  belongs_to :pointable, :polymorphic => true, :counter_cache => true, :touch => true

  validates_presence_of :pointable_id, :user_id
  validates_uniqueness_of :pointable_id, :scope => [:user_id, :pointable_type]
  validate :user_id_and_pointable

  def user_id_and_pointable
    unless pointable == nil
      errors.add(:password, "You can't point your own post") if user_id == pointable.user_id
    end
  end
end
