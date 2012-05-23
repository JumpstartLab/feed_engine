class InstagramItem < ActiveRecord::Base
  include Streamable
  attr_accessible :image, :image_id

  belongs_to :user 

  has_many :stream_items, :as => :streamable

  serialize :image 
end
