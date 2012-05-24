class LinkPost < Post
  has_many :awards, as: :awardable
  include PointAwarder

  validates :content, :length => { :maximum => 2048 }

  validate do
    unless self.content.match(ImageValidator::URI)
      self.errors[:base] << t(:invalid_image_uri)
    end
  end

  def template
    "link_post"
  end

  def decorate
    LinkPostDecorator.decorate(self)
  end
end