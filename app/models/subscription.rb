class Subscription < ActiveRecord::Base
  attr_accessible :user, :subscriber, :subscriber_id, :user_id

  belongs_to :user
  belongs_to :subscriber, :class_name => "User"
end