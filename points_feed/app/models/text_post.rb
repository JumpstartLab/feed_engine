class TextPost < Post
  validates :content, :length => { :maximum => 512 }

  def decorate
    TextPostDecorator.decorate(self)
  end

  def template
    "text_post"
  end
end