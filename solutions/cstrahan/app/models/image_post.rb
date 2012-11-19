# == Schema Information
#
# Table name: image_posts
#
#  id                 :integer         not null, primary key
#  description        :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  image              :string(255)
#  external_image_url :string(255)

class ImagePost < ActiveRecord::Base

  attr_accessible :description, :external_image_url, :image, :user_id

  mount_uploader :image, ImageUploader

  validates_length_of :description, maximum: 256

  validates_length_of :external_image_url,
    maximum: 2048,
    unless: "image.present?"

  validates :external_image_url, url:
    { message:  "Photo url must begin with http or https",
      :unless => "image.present?" }

  validates_format_of :external_image_url,
    with: /\.(jpg|gif|bmp|png)$/,
    message: "Photo url must end in .jpeg, .jpg, .gif, .bmp, or .png",
    unless: "image.present?"

  has_one :post, :as => :postable, dependent: :destroy
  has_one :user, :through => :post

  # Because carrierwave sucks.
  def remote_image_url=(url)
    raise "don't use this!"
  end

  def download_failed?
    @download_failed
  end

  def link
    api_item_url(user_display_name: user.display_name, id: id)
  end

  def url
    image_url(:big) || external_image_url
  end
end
