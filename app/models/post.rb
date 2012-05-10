module Post

  def self.all
    posts = Image.all + Text.all + Link.all 
    posts.sort_by do |post|
      post.created_at
    end
  end

  def self.included(base)
    base.class_eval do
      attr_accessible :content, :type, :user_id
      belongs_to :user
      validate :check_content_length
      validates :content, presence: true
      define_method("check_content_length") do
        class_str = self.class.to_s.capitalize
        max = Module.const_get("MAX_#{class_str}_LENGTH".upcase.to_sym)
        unless self.content.length <= max
          errors.add(:content, "#{class_str} posts must be shorter than #{max} characters")
        end
      end
      private :check_content_length
    end
  end
end
