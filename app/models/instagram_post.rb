# == Schema Information
#
# Table name: instagram_posts
#
#  id           :integer         not null, primary key
#  instagram_id :string(255)     not null
#  url          :string(255)
#  refeed_id    :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class InstagramPost < ActiveRecord::Base
  attr_accessible :instagram_id, :url, :refeed_id, :created_at, :updated_at

  has_one :post, :as => :postable, dependent: :destroy
  has_one :user, :through => :post
end
