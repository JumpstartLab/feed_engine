class Message < ActiveRecord::Base
  attr_accessible :body, :poster_id

  validates_length_of :body, in: 1..512
  validates_presence_of :poster_id

end
