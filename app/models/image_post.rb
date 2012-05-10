# == Schema Information
#
# Table name: image_posts
#
#  id               :integer         not null, primary key
#  remote_image_url :string(255)
#  description      :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  image            :string(255)
#

class ImagePost < ActiveRecord::Base
  attr_accessible :description, :remote_image_url, :image
  mount_uploader :image, ImageUploader


  # validates_presence_of :remote_image_url
  validates_length_of :remote_image_url, maximum: 2048, unless: "image.present?"
  validates_format_of :remote_image_url,
    with: /http(s?):/,
    message: "Photo url must begin with http or https",
    unless: "image.present?"
  # validates_format_of :remote_image_url,
  #   with: /.(jpg|png|gif|jpeg|bmp)/,
  #   message: "Photo url must end in .jpeg, .jpg, .gif, .bmp, or .png",
  #   unless: "image.present?"
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
