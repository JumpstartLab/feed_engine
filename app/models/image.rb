class Image < Growl
  # attr_accessible :title, :body
  validates_presence_of :link, message: "You must provide a link to an image."
  validate :check_image_link
  validates_length_of :comment, :within => 3..256
  IMAGE_VALIDATOR_REGEX = "^https?:\/\/(?:[a-z\-]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png)$"

  def check_image_link
    if link.match(IMAGE_VALIDATOR_REGEX)
      errors.add(:link, "URL must start with http and be a .jpg, .gif, or .png")
    elsif link.size > 2048
      errors.add(:link, "Given URL needs to be less then 2048 characters")
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