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

class Message < ActiveRecord::Base
  attr_accessible :body, :poster_id

  validates_length_of :body, in: 1..512
  validates_presence_of :poster_id

end
