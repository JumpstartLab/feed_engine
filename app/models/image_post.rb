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

# CCS: Note that CarrierWave sets #remote_image_url to nil...
# I have no idea why, but I've blown plenty of fucking time
# in the process of figuring that out.
class ImagePost < ActiveRecord::Base
  attr_accessible :description, :remote_image_url, :image
  mount_uploader :image, ImageUploader

  validates_length_of :description, maximum: 256

  validates_length_of :remote_image_url,
    maximum: 2048,
    unless: "image.present?"

  validates_format_of :remote_image_url,
    with: %r{^https?://},
    message: "Photo url must begin with http or https",
    unless: "image.present?"

   validates_format_of :remote_image_url,
     with: %r{(?:[a-z\-]+\.)+[a-z]{2,6}(?:/[^/#?]+)+\.(?:jpg|gif|bmp|png)$},
     message: "Photo url must end in .jpeg, .jpg, .gif, .bmp, or .png",
     unless: "image.present?"

  # Work around carrierwave blowing up.
  alias :old_remote_image_url= :remote_image_url=
  def remote_image_url=(url)
    # This is to set the _before_type_cast attribute.
    write_attribute("remote_image_url", url)

    self.old_remote_image_url = url
  rescue
    @download_failed = true
  end

  def download_failed?
    @download_failed
  end

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
