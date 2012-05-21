class Text < ActiveRecord::Base
  # include PostsHelper
  attr_accessible :content
  validates :content, length: { maximum: 512 }, presence: true
  has_one :post, :as => :postable
end
