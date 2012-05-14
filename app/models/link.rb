class Link < Growl
  validates_presence_of :link, message: "You must provide a link."
  validates_length_of :link, :maximum => 2048
  validates_format_of :link, :with => /^(https?):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_length_of :comment, :within => 3..256, :allow_blank => true
  after_validation :send_photo_to_amazon

  def send_photo_to_amazon
    begin
      self.photo = open(thumbnail_url)
    rescue
      #errors.add(:link, "Photo does not exist")
    end
  end

  def icon
    "glyphicons_036_file.png"
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
#  external_id        :integer
#

