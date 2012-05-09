class Message < Growl
  validates_presence_of :comment, message: "You must provide a message."
  validates_length_of :comment, :maximum => 512
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

