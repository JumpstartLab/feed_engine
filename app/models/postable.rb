module Postable
  def self.included(base)
    base.instance_eval do
      attr_accessible :poster_id
      after_create :create_item
      validates_presence_of :poster_id
      has_one :item, :as => :post
      belongs_to :user, :foreign_key => :poster_id
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

  def github_event?
    is_a? GithubEvent
  end

  def tweet?
    is_a? Tweet
  end

  def create_item
    Item.create(
      :post_id => id,
      :post_type => self.class.to_s,
      :poster_id => poster_id
    )
  end
end
