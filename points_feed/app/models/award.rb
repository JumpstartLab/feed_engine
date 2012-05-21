class Award < ActiveRecord::Base
  attr_accessible :user_id, :awardable_id, :awardable_type
  belongs_to :user
  belongs_to :awardable, polymorphic: true
  validates_uniqueness_of :user_id, :scope => [ :awardable_id, :awardable_type ]
end
