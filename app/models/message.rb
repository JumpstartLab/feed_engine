# == Schema Information
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  body       :text
#  poster_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  points     :integer         default(0)
#

# Posts that only have text
class Message < ActiveRecord::Base
  include Postable

  attr_accessible :body

  include Postable

  validates_length_of :body, in: 1..512
  validates_presence_of :poster_id
end
