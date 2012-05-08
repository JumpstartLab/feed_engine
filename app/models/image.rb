class Image < Growl
  # attr_accessible :title, :body
  validates_presence_of :link, message: "You must provide a link to an image."
  validate :check_image_link
  IMAGE_VALIDATOR_REGEX = "^https?:\/\/(?:[a-z\-]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png)$"

  def check_image_link
    unless link.match(IMAGE_VALIDATOR_REGEX)
      errors.add(:link, "Given URL does not meet a valid image format.")
    end
  end

end
# == Schema Information
#
# Table name: growls
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  comment    :text
#  link       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#