require "open-uri"

class Growl < ActiveRecord::Base
  attr_accessible :comment, :link, :user

  validates_presence_of :type
  belongs_to :user
  has_one :meta_data
  has_attached_file :photo,
<<<<<<< HEAD
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :styles => {
                                  :medium => "300x300>",
                                  :thumb => "100x100>"
                               }
=======
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :styles => {
                    :medium => "300x300>",
                    :thumb => "100x100>"
                 }
  scope :by_date, order("created_at DESC")

>>>>>>> 5f285f246675bb48b8b3449c213823ede9e69db7
  def self.for_user(display_name)
    user = User.where{username.matches display_name}.first
    user ? user.growls : nil
  end

  def title
    meta_data ? meta_data.title : ""
  end

  def thumbnail_url
    meta_data ? meta_data.thumbnail_url : ""
  end

  def description
    meta_data ? meta_data.description : ""
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

