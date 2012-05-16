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

  def item
    Item.find_by_post_id_and_post_type(id, self.class.to_s.downcase)
  end

  def create_item
    Item.create(
      :post_id => id,
      :post_type => self.class.to_s,
      :poster_id => poster_id
    )
  end

  def respond_to?(method_name, include_private = false)
    if method_name.to_s == "#{self.class.name.underscore}?"
      true
    elsif klass = method_name.to_s.chomp('?').classify.safe_constantize
      if klass.ancestors.include?(Postable)
        false
      else
        super
      end
    else
      super
    end
  end

  private

  def method_missing(method_name, *args, &block)
    if method_name.to_s == "#{self.class.name.underscore}?"
      true
    elsif klass = method_name.to_s.chomp('?').classify.safe_constantize
      if klass.ancestors.include?(Postable)
        false
      else
        super
      end
    else
      super
    end
  end
end
