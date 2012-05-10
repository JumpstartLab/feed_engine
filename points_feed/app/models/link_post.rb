class LinkPost < Post
  validates :content, :length => { :maximum => 2048 }
  validates_format_of :content, 
  :message => "for Link Posts must contain a valid link.",
  :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

  def template
    "link_post"
  end

  def decorate
    LinkPostDecorator.decorate(self)
  end
end