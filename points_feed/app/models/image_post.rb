class ImagePost < Post
  has_many :awards, as: :awardable
  include PointAwarder

  validates :content, :length => { :maximum => 2048 }
  validate :has_valid_image

  def has_valid_image
    return true if file.present?
    unless content.match(/\.(png|jpg|jpeg|gif|bmp)$/) && content.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix)
      self.errors[:base] << "Image must contain a link to an image of type png, jpg, jpeg, gif, or bmp."
    end
  end

  def image_url
    file_url || content
  end

  def template
    "image_post"
  end

  def decorate
    ImagePostDecorator.decorate(self)
  end
end