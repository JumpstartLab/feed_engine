class ImagePost < Post
  validates :content, :length => { :maximum => 2048 }
end