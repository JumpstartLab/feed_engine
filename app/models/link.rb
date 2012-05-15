class Link < Growl
  include LinkValidations

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

