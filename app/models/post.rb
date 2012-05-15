module Post
  def self.included(base)
    base.class_eval do
      attr_accessible :content, :type, :user_id
      belongs_to :user
    end
  end

  def self.for_feed(user_display_name)
    User.find_by_display_name!(user_display_name).posts
  end
end