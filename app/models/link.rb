# == Schema Information
#
# Table name: links
#
#  id          :integer         not null, primary key
#  description :text
#  url         :text
#  poster_id   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  points      :integer         default(0)
#

# Posts with links
class Link < ActiveRecord::Base
  include ExternalContent
  include Postable

  attr_accessible :description, :url
end
