class Image < ActiveRecord::Base
  include Post
  validates :comment, length: { maximum: 256 }
end
