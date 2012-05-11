class Link < Growl
  validates_presence_of :link, message: "You must provide a link."
  validates_length_of :link, :maximum => 2048
  validates_format_of :link, :with => /^(https?):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_length_of :comment, :within => 3..256, :allow_blank => true
  after_validation :send_photo_to_amazon

  def self.new_link(input)
    link = Link.new(
                      comment: input[:comment],
                      link: input[:link],
                      )
    link.create_meta_data(
                           description: input[:description],
                           title: input[:title],
                           thumbnail_url: input[:thumbnail_url]
                           )
    link
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

