class Link < Growl
  validates_presence_of :link, message: "You must provide a link."
  validates_length_of :link, :maximum => 2048
  validates_format_of :link, :with => /^(https?):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_length_of :comment, :within => 3..256, :allow_blank => true

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

