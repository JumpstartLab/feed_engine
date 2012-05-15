class TwitterItem < ActiveRecord::Base
  attr_accessible :tweet

  belongs_to :user
  has_many :stream_items, :as => :streamable

  serialize :tweet
end
