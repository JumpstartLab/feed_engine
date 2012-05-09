class Growl < ActiveRecord::Base
  attr_accessible :comment, :link
  validates_presence_of :type
<<<<<<< HEAD
  belongs_to :user
=======

  belongs_to :user

  def self.for_user(display_name)
    user = User.where{username.matches display_name}.first
    user.growls
  end

>>>>>>> a1491f2329a12a138ce80730db0f3fff9e32fe7c
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