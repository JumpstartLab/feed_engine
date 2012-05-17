require "open-uri"

class Growl < ActiveRecord::Base
  attr_accessible :comment, :link, :user, :type,
                  :external_id, :created_at, :user_id
  validates_presence_of :type
  belongs_to :user
  has_one :meta_data, :autosave => true, dependent: :destroy
  has_many :regrowls
  include HasUploadedFile
  scope :by_date, order("created_at DESC")

  def self.by_type_and_date(type=nil)
    if type
      by_type(type).by_date.includes(:meta_data).includes(:user)
    else
      by_date.includes(:meta_data).includes(:user)
    end
  end

  def self.by_type(input)
    where(type: input)
  end

  ["title", "thumbnail_url", "description"].each do |method|
    define_method method.to_sym do
      meta_data ? meta_data.send(method.to_sym) : ""
    end
  end

  ["link", "message", "image"].each do |method|
     define_method "#{method}?".to_sym do
        self.type == method.capitalize
    end
  end

  def regrowled(new_user_id)
    new_growl                     = self.dup
    if user_id != new_user_id
      new_growl.user_id           = new_user_id
      new_growl.regrowled_from_id = id
      new_growl.save
    else
      false
    end
  end

  def self.regrowled_new(growl_id,user_id)
    growl = Growl.find(growl_id).dup
    if growl.user_id != user_id
      growl.user_id = user_id
      growl.regrowled_from_id = growl_id
      growl.save
    end
  end

  def original_growl?
    regrowled_from_id == nil
  end

  def get_display_name
    if original_growl?
      user.display_name
    else
      original_growl.user.display_name
    end
  end

  def get_gravatar
    if original_growl?
      user.avatar
    else
      original_growl.user.avatar
    end
  end

  def original_growl
    Growl.find(regrowled_from_id)
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

