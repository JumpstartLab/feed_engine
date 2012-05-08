class Link < Growl
  validates_presence_of :link, message: "You must provide a link to an image."
  validates_length_of :link, :maximum => 2048
  validates_format_of :link, :with => /^(https?):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_length_of :comment, :maximum => 256

  def check_link
    unless link.match(LINK_VALIDATOR_REGEX)
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

