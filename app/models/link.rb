class Link < Growl
  validates_presence_of :link, message: "You must provide a link to an image."
  validate :check_image_link
  validates_length_of :comment, :maximum => 256
  IMAGE_VALIDATOR_REGEX = "^https?:\/\/(?:[a-z\-]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png)$"


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

