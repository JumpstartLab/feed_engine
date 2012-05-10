class Image < ActiveRecord::Base
  include Post
  attr_accessible :comment, :picture, :remote_picture_url
  before_create :set_content
  #mount_uploader :picture, PictureUploader
  validates :comment, length: { maximum: 256 }
  validates :remote_picture_url, length: { maximum: 2048 }

private

  def set_content
    self.content = remote_picture_url
  end
end
