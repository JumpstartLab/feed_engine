class Text < ActiveRecord::Base
  # include PostsHelper
  attr_accessible :content
  validates :content, length: { maximum: 512 }, presence: true
  has_many :points, :through => :posts
  has_many :posts, :as => :postable
end
