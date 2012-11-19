class ImagePost < Post
  has_many :awards, as: :awardable
  include PointAwarder

  validates :content, :length => { :maximum => 2048 }
  validate :has_valid_image

  def has_valid_image
    return true if file.present?
    unless content.match(ImageValidator::FILENAME) &&
           content.match(ImageValidator::URI)
      self.errors[:base] << t(:invalid_image_file_or_uri)
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