class StreamItem < ActiveRecord::Base
  attr_accessible :streamable_id, :streamable_type, :refeed
  belongs_to :user
  belongs_to :streamable, :polymorphic => true

  delegate :author, :to => :streamable

  def self.new_stream_item_from_json(user_id, parsed_json)
    parsed_json["type"].constantize.create_from_json(user_id, parsed_json)
  end
end
