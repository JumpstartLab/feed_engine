class TextPost < Post
  validates :content, :length => { :maximum => 512 }

  def template
    "text_post"
  end
end