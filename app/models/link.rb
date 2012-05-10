class Link < ActiveRecord::Base
  attr_accessible :comment
  validates :comment, length: { maximum: 256, message: "The comment must be no longer than 256 characters." }
  include Post
end
