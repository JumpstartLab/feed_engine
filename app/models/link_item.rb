class LinkItem < ActiveRecord::Base
  attr_accessible :comment, :url, :user_id
  belongs_to :user

  validates_presence_of :url
  validates_length_of :url, :maximum => 2048
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_length_of :comment, :maximum => 256
end
