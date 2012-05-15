class TwitterAccount < ActiveRecord::Base
  belongs_to :authentication
  has_one :user, :through => :authentication
  # attr_accessible :title, :body
end
