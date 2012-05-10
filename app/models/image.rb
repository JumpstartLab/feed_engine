class Image < ActiveRecord::Base
  include Post
  validates_format_of :content, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_format_of :content, with: /\.(png|jpg|gif|jpeg)$/
  attr_accessible :comment, :picture, :remote_picture_url
  #mount_uploader :picture, PictureUploader
  validates :comment, length: { maximum: 256 }
  validates :remote_picture_url, length: { maximum: 2048 }

end
