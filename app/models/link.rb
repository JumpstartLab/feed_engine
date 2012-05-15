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
#

# Posts with links
class Link < ActiveRecord::Base
  attr_accessible :description, :poster_id, :url

  include ExternalContent
  include Postable

end
