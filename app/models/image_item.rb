class ImageItem < ActiveRecord::Base
  IMAGE_REGEX = /^https?:\/\/(?:[a-z\-]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png)$/ix
  attr_accessible :comment, :url, :user_id

  validates_presence_of :url
  validates_length_of :url, :maximum => 2048
  validates_format_of :url, :with => IMAGE_REGEX
  validates_length_of :comment, :maximum => 256
end
