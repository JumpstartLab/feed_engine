# == Schema Information
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  body       :text
#  poster_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# Posts that only have text
class Message < ActiveRecord::Base
  include Postable

  attr_accessible :body

  validates_length_of :body, in: 1..512
end
