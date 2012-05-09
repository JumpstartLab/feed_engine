# == Schema Information
#
# Table name: text_posts
#
#  id         :integer         not null, primary key
#  text       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class TextPost < ActiveRecord::Base
  attr_accessible :text, :created_at, :updated_at

  validates_length_of   :text, within: 1..512
end
