class LinkItem < ActiveRecord::Base
  include Streamable
  LINK_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  attr_accessible :comment, :url

  validates_presence_of :url
  validates_length_of :url, :maximum => 2048
  validates_format_of :url, :with => LINK_REGEX, :message => "Please enter a valid url" 
  validates_length_of :comment, :maximum => 256

  has_many :stream_items, :as => :streamable
  has_many :users, :through => :stream_items

  def self.create_from_json(user_id, parsed_json)
    new(:user_id => user_id, :url => parsed_json["link_url"], :comment => parsed_json["comment"])
  end
end
