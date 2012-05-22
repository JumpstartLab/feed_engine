class InstagramPhoto < Growl
  belongs_to :user
  after_validation :send_photo_to_amazon

  def send_photo_to_amazon
    begin
      self.photo = open(link)
    rescue
      #errors.add(:link, "Photo does not exist")
    end
  end

  def icon
    "glyphicons/glyphicons_400_instagram.png"
  end
end
