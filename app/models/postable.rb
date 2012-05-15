module Postable
  def self.included(base)
    base.instance_eval do
      attr_accessible :poster_id
      after_create :create_item
      validates_presence_of :poster_id
      belongs_to :item, :polymorphic => true, :dependent => :destroy
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

  def create_item
    Item.create(
      :post_id => id,
      :post_type => self.class.to_s.downcase,
    )
  end
end
