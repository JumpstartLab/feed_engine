# == Schema Information
#
# Table name: images
#
#  id          :integer         not null, primary key
#  description :text
#  url         :text
#  poster_id   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  points      :integer         default(0)
#

# Posts with images
class Image < ActiveRecord::Base
  include ExternalContent
  include Postable

  attr_accessible :description, :url

  validates_format_of(
    :url,
    with: /.*\/*[A-Za-z0-9]\.(jpg|jpeg|png|bmp|gif)$/,
    message: "must be a valid image (.jpg, .jpeg, .png, .bmp, .gif)",
    allow_blank: true
  )
end
