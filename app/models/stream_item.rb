class StreamItem < ActiveRecord::Base
  attr_accessible :streamable_id, :streamable_type, :refeed
  belongs_to :user
  belongs_to :streamable, :polymorphic => true
  validates_uniqueness_of :streamable_id, :scope => [:user_id, :streamable_type]
  validate :uniqueness_of_author

  delegate :author, :to => :streamable

  def self.new_stream_item_from_json(user_id, parsed_json)
    parsed_json["type"].constantize.create_from_json(user_id, parsed_json)
  end

  def uniqueness_of_author
    if StreamItem.where(:streamable_type => self.streamable_type).where(:streamable_id => self.streamable_id).where(:refeed => false).any? && self.refeed == false
      errors.add(:refeed, "Can't have multiple original stream items")
    end
  end
end
