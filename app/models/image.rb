class Image < ActiveRecord::Base
  attr_accessible :description, :poster_id, :url

  include ExternalContent

  validates_format_of( :url, 
                       with: /.*\.(jpg|jpeg|png|bmp|gif)$/, 
                       message: "Invalid image url or type")
end
