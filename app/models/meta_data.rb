class MetaData < ActiveRecord::Base
  attr_accessible :description, :thumbnail_url, :title
  belongs_to :growl

  def self.find_link_data(url)
    embedly = Embedly::API.new(key: "a4a5a91a9a3811e1be1d4040aae4d8c9",
                               :user_agent => 'Mozilla/5.0')
    data = embedly.oembed :url => url
    MetaData.new(
                    title: data[0].title, description: data[0].description,
                    thumbnail_url: data[0].thumbnail_url
                    )
  end
end
# == Schema Information
#
# Table name: meta_data
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  description   :string(255)
#  thumbnail_url :string(255)
#  growl_id      :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

