class TextItem < ActiveRecord::Base
  attr_accessible :body, :user_id
  belongs_to :user
  
  validates_presence_of :body
  validates_length_of :body, :maximum => 512
end
