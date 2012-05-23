class Text < ActiveRecord::Base
  # include PostsHelper
  attr_accessible :content
  validates :content, length: { maximum: 512 }, presence: true
  has_many :points, :through => :post
  has_many :posts, :as => :postable
end
