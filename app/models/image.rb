class Image < ActiveRecord::Base
  attr_accessible :comment, :picture, :remote_picture_url, :user_id
  belongs_to :user
  mount_uploader :picture, PictureUploader

  validates :comment, length: { maximum: 256 }
  validates :remote_picture_url, length: { maximum: 2048 }

end
