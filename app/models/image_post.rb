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
  attr_accessible :description, :url

  validates_presence_of :url
  validates_length_of :url, maximum: 2048
  validates_format_of :url,
    with: /http(s?):/,
    message: "Photo url must begin with http or https"
  validates_format_of :url,
    with: /.(jpg|png|gif|jpeg|bmp)/,
    message: "Photo url must end in .jpeg, .jpg, .gif, .bmp, or .png"
  validates_length_of :description, maximum: 256

  def self.stream
    stream = []
    link_posts = LinkPost.all
    image_posts = ImagePost.all
    text_posts = TextPost.all
    stream << [link_posts, image_posts, text_posts]
    stream.flatten
  end

  def self.order_stream
    stream.sort_by {|content| content.created_at}.reverse
  end
end
