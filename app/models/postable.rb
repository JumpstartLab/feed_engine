module Postable
  def self.included(base)
    base.instance_eval do
      attr_accessible :poster_id
      after_save :create_item
      validates_presence_of :poster_id
      has_one :item, :as => :post, :dependent => :destroy
      belongs_to :user, :foreign_key => :poster_id
    end
  end

  def type
    self.class.name
  end

  def create_item
    Item.create(
      :post_id => id,
      :post_type => self.class.to_s,
      :poster_id => poster_id
    )
  end

  def respond_to?(method_name, include_private = false)
    if predicate?(method_name)
      true
    elsif klass = predicate_class_name(method_name)
      if postable?(klass)
        true
      else
        super
      end
    else
      super
    end
  end

  def local_created_at
    if created_at
      created_at.localtime
    end
  end

  def increase_point_count
    new_point_count = points + 1
    update_attribute(:points, new_point_count)
  end

  private

  def predicate?(method_name)
    method_name.to_s == "#{self.class.name.underscore}?"
  end

  def postable?(klass)
    klass.ancestors.include?(Postable)
  end

  def predicate_class_name(method_name)
    method_name.to_s.chomp('?').classify.safe_constantize
  end

  def method_missing(method_name, *args, &block)
    if predicate?(method_name)
      true
    elsif klass = predicate_class_name(method_name)
      if postable?(klass)
        false
      else
        super
      end
    else
      super
    end
  end
end
