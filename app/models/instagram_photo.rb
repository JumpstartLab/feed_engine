class InstagramPhoto < Growl
  belongs_to :user

  def icon
    "glyphicons/glyphicons_400_instagram.png"
  end
end
