class Image < ActiveRecord::Base
  include Post
  attr_accessible :comment, :picture, :remote_picture_url
  #mount_uploader :picture, PictureUploader
  validates :comment, length: { maximum: 256 }
  validates :remote_picture_url, length: { maximum: 2048 }

end
