class LinkItem < ActiveRecord::Base
  include Streamable
  attr_accessible :comment, :url

  validates_presence_of :url
  validates_length_of :url, :maximum => 2048
  validates_format_of :url, :with => URI::regexp(%w(http https)), :message => "URL needs to start with http/https"
  validates_length_of :comment, :maximum => 256

  has_many :stream_items, :as => :streamable
  has_many :users, :through => :stream_items

  def self.create_from_json(user_id, parsed_json)
    new(:user_id => user_id, :url => parsed_json["link_url"], :comment => parsed_json["comment"])
  end
end
