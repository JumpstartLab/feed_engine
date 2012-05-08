class TextPost < Post
  validates :content, :length => { :maximum => 512 }
end