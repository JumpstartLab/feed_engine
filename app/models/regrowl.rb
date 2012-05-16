class Regrowl < ActiveRecord::Base
  attr_accessible :growl_id, :user_id
  belongs_to :growl
  belongs_to :user
end
