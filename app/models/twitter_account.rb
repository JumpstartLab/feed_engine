class TwitterAccount < ActiveRecord::Base
  belongs_to :authentication
  has_one :user, :through => :authentication
  attr_accessible :authentication, :uid, :nickname, :initial_status, :image
end
