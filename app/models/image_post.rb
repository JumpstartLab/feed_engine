# == Schema Information
#
# Table name: image_posts
#
#  id          :integer         not null, primary key
#  url         :string(255)
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ImagePost < ActiveRecord::Base
  attr_accessible :description, :url, :user_id

  validates_presence_of :url
  validates_length_of :url, maximum: 2048
  validates_format_of :url,
    with: /http(s?):/,
    message: "Photo url must begin with http or https"
  validates_format_of :url,
    with: /.(jpg|png|gif|jpeg|bmp)/,
    message: "Photo url must end in .jpeg, .jpg, .gif, .bmp, or .png"
  validates_length_of :description, maximum: 256

  has_one :post, :as => :postable
  has_one :user, :through => :post
end
