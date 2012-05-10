class StreamItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :streamable, :polymorphic => true

  def self.translate_batch(items)
    items.collect do |item|
      eval "#{item.streamable_type}.find #{item.streamable_id}"
    end
  end
end
