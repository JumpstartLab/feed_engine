class ImagePost < Post
  validates :content, :length => { :maximum => 2048 }
  validate :has_valid_image

  def validate_presence_of_content?
    false
  end


  def has_valid_image
    return true if file.present?
    unless content.match(/\.(png|jpg|jpeg|gif|bmp)$/) && content.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix)
      self.errors.add(:content, "Image posts must contain a valid image link")
    end
  end

  def image_url
    file_url || content
  end

end