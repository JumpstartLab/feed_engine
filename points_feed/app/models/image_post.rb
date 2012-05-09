class ImagePost < Post
  validates :content, :length => { :maximum => 2048 }
  validates_format_of :content, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  validates_format_of :content, :with => /\.(png|jpg|jpeg|gif|bmp)$/
end