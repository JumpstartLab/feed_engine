module Postable
  def self.included(base)
    base.instance_eval do
      attr_accessible :poster_id
      after_create :create_item
      validates_presence_of :poster_id
      belongs_to :item, :polymorphic => true
    end
  end

  def type
    self.class.name
  end

  def message?
    is_a? Message
  end

  def image?
    is_a? Image
  end

  def link?
    is_a? Link
  end

  def tweet?
    is_a? Tweet
  end

  def item
    Item.find_by_post_id_and_post_type(id, self.class.to_s.downcase)
  end

  def create_item
    Item.create(
      :post_id => id,
      :post_type => self.class.to_s.downcase,
      :poster_id => poster_id
    )
  end
end
