class TextItem < ActiveRecord::Base
  attr_accessible :body, :user_id

  validates_presence_of :body
  validates_length_of :body, :maximum => 512
  has_many :stream_items, :as => :streamable
  belongs_to :user

  def self.create_from_json(user_id, parsed_json)
    new(:user_id => user_id,:body => parsed_json["body"])
  end

  def to_param
    stream_items.where(:user_id => user.id).first.id
  end
end
