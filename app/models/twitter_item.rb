class TwitterItem < ActiveRecord::Base
  attr_accessible :json_blob

  belongs_to :user
  has_many :stream_items, :as => :streamable

  serialize :json_blob
end
