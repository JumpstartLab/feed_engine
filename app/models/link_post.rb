# == Schema Information
#
# Table name: link_posts
#
#  id          :integer         not null, primary key
#  url         :string(255)
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  points      :integer         default(0)
#  refeed_id   :integer
#

class LinkPost < ActiveRecord::Base
  attr_accessible :description, :url, :user_id

  validates_presence_of :url
  validates_length_of :url, maximum: 2048
  validates_format_of :url,
    with: /http(s?):/,
    message: "Url must begin with http or https"
  validates_length_of :description, maximum: 256

  has_one :post, :as => :postable, dependent: :destroy
  has_one :user, :through => :post

  def refeed?
    refeed_id.present?
  end
end
