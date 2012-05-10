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
#

class Image < ActiveRecord::Base
  attr_accessible :description, :poster_id, :url

  include ExternalContent

  validates_format_of( :url, 
                       with: /.*\.(jpg|jpeg|png|bmp|gif)$/,
                       message: "for image must end with jpg, jpeg, gif, bmp, or png",
                       allow_blank: true)
end
