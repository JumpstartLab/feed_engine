class Image < ActiveRecord::Base
  # include PostsHelper
  attr_accessible :content, :comment, :picture, :remote_picture_url
  validates_format_of :content, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_format_of :content, with: /\.(png|jpg|gif|jpeg)$/
  validates :content, length: { maximum: 2048 }, presence: true
  #mount_uploader :picture, PictureUploader
  validates :comment, length: { maximum: 256 }
  has_many :posts, :as => :postable

end
