class Growl < ActiveRecord::Base
  attr_accessible :comment, :link
  validates_presence_of :type

  belongs_to :user

  def self.for_user(display_name)
    user = User.where{username.matches display_name}.first
    user.growls
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