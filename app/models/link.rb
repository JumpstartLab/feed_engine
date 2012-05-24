class Link < ActiveRecord::Base
  # include PostsHelper
  attr_accessible :comment, :content
  validates :comment, length: { maximum: 256, message: "The comment must be no longer than 256 characters." }
  validates_format_of :content, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates :content, length: { maximum: 2048 }, presence: true
  has_many :posts, :as => :postable
  has_many :points, :through => :posts
  
end
