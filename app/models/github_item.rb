class GithubItem < ActiveRecord::Base
  include Streamable
  attr_accessible :event, :event_id

  validates_presence_of :event_id


  belongs_to :user

  has_many :stream_items, :as => :streamable

  serialize :event

  def self.create_from_json(user_id, parsed_json)
    event_id = parsed_json["id"]
    new(:user_id => user_id, event_id: parsed_json["id"], event: parsed_json)
  end
end
