module Post
  def self.included(base)
    base.class_eval do
      attr_accessible :content, :type, :user_id
      belongs_to :user
    end
  end
end