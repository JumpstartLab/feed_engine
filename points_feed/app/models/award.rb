class Award < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :awardable, polymorphic: true
end
