
module Post

  def self.all_by_user(user_id)
    posts = Image.where(user_id: user_id) + Text.where(user_id: user_id) + Link.where(user_id: user_id) 
    posts.sort_by do |post|
      post.created_at
    end
  end

  def self.included(base)
    base.class_eval do
      attr_accessible :content, :type, :user_id
      belongs_to :user
      class_name = base.to_s
    end
  end
end

