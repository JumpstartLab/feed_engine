class Subscription < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :user_id
end
