class Image < ActiveRecord::Base
  include Post
  attr_accessor :url
  validates :comment, length: { maximum: 256 }
end
