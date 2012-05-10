class LinkItem < ActiveRecord::Base
  attr_accessible :comment, :url, :user_id

  validates_presence_of :url
  validates_length_of :url, :maximum => 2048
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_length_of :comment, :maximum => 256

  has_many :stream_items, :as => :streamable
  has_many :users, :through => :stream_items
end
