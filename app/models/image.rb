class Image < Growl
  IMAGE_VALIDATOR_REGEX = /^https?:\/\/(?:[a-z\-\d]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png)$/ix
  validates_presence_of :link, message: "You must provide a link to an image."
  validates_format_of :link, :with => IMAGE_VALIDATOR_REGEX, message: "URL must start with http and be a .jpg, .gif, or .png"
  validates_length_of :link, :within => 3..2048, message: "Given URL needs to be less then 2048 characters"
  validates_length_of :comment, :within => 3..256, :allow_blank => true
  after_validation :send_photo_to_amazon
  belongs_to :user

  # def self.new_image(input)
  #   Image.new(
  #             comment: input[:comment],
  #             link: input[:link],
  #             )
  # end

  def send_photo_to_amazon
    begin
      self.photo = open(link)
    rescue
      errors.add(:link, "Photo does not exist")
    end
  end
end
# == Schema Information
#
# Table name: growls
#
#  id                 :integer         not null, primary key
#  type               :string(255)
#  comment            :text
#  link               :text
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  user_id            :integer
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

