class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscriber, :class_name => "User"

  attr_accessible :user, :subscriber
end