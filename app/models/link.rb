class Link < ActiveRecord::Base
  include Post
  validates_format_of :content, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates :content, length: { maximum: 2048 }, presence: true
end
