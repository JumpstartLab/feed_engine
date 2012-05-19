class TextItem < ActiveRecord::Base
  include Streamable
  attr_accessible :body

  validates_presence_of :body
  validates_length_of :body, :maximum => 512
  has_many :stream_items, :as => :streamable
  has_many :points, :class_name => "Point",  :as => :pointable


  def self.create_from_json(user_id, parsed_json)
    new(:user_id => user_id,:body => parsed_json["body"])
  end
end
