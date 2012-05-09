class Image < ActiveRecord::Base
  attr_accessible :description, :poster_id, :url
  validates_presence_of :poster_id
  validates_length_of :url, in: 1..2048
  validates_length_of :description, in: 1..256
  validates_format_of( :url, 
                       with: /\A^(http|https):[\/A-Za-z0-9-~.&@\#$%_]*(jpg|jpeg|png|bmp|gif)$\Z/i, 
                       message: "Invalid link format")
end
