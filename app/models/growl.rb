require "open-uri"

class Growl < ActiveRecord::Base
  attr_accessible :comment, :link, :user, :type,
                  :external_id, :original_created_at,
                  :user_id, :event_type
                  
  validates_presence_of :type
  belongs_to :user
  has_one :meta_data, :autosave => true, dependent: :destroy
  has_many :regrowls
  include HasUploadedFile
  scope :by_date, order("created_at DESC")
  after_create :set_original_created_at

  def self.by_type_and_date(type=nil)
    if type
      by_type(type).by_date.includes(:meta_data).includes(:user)
    else
      by_date.includes(:meta_data).includes(:user)
    end
  end

  def self.since(date)
    # ASK YOHO.
    where{ created_at.gt Time.at(date+1) }
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

  def self.build_refeeded(user_id,refeeded_from_user_id)
    growl = Growl.find(id).dup
    growl.write_attributes(user_id: user_id,
                           refeeded_from_user_id: user_id)
  end

  def original_growl?
    regrowled_from_id.nil?
  end

  def regrowled?
    regrowled_from_id.present?
  end

  def regrowl_link
    if regrowled?
      "http://api.hungrlr.com/feeds/#{get_user.slug}/items/#{id}"
    else
      ""
    end
  end

  def get_user
    if original_growl?
      user
    else
      original_growl.user
    end
  end

  def get_display_name
    get_user.display_name
  end

  def get_gravatar
    get_user.display_name
  end

  def original_growl
    Growl.find(regrowled_from_id)
  end
  
  private

  def set_original_created_at
    original_created_at = DateTime.now unless original_created_at
    self.save
  end

end

# == Schema Information
#
# Table name: growls
#
#  id                  :integer         not null, primary key
#  type                :string(255)
#  comment             :text
#  link                :text
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  user_id             :integer
#  photo_file_name     :string(255)
#  photo_content_type  :string(255)
#  photo_file_size     :integer
#  photo_updated_at    :datetime
#  original_created_at :datetime
#  event_type          :string(255)
#

