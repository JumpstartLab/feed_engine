module Post

  VALID_URL = Regexp.new("\b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/)))")

  def self.all
    posts = Image.all + Text.all + Link.all 
    posts.sort_by do |post|
      post.created_at
    end
  end

  def self.for_user(user)
    posts = []
    TYPES.each do |klass|
      posts += klass.find_all_by_user_id(user.id.to_s)
    end
    posts
  end

  def self.included(base)
    base.class_eval do
      attr_accessible :content, :type, :user_id
      belongs_to :user

      class_name = base.to_s
      max = Module.const_get("MAX_#{class_name}_LENGTH".upcase.to_sym)
      validates :content, length: {maximum: max}, presence: true
    end
  end
end
