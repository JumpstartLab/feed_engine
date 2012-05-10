class Text < ActiveRecord::Base
  include Post
  validates :content, length: { maximum: 512 }, presence: true
end
