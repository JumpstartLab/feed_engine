class TwitterItem < ActiveRecord::Base
  include Streamable
  attr_accessible :tweet

  has_many :stream_items, :as => :streamable

  serialize :tweet
end
