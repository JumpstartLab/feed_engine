require "open-uri"

class Growl < ActiveRecord::Base
  attr_accessible :comment, :link, :user, :type,
                  :external_id, :original_created_at,
                  :user_id, :event_type, :regrowled_from_id

  validates_presence_of :type, :user_id, :user_id

  belongs_to :user
  has_one :meta_data, :autosave => true, dependent: :destroy
  has_many :regrowls
  include HasUploadedFile

  scope :by_date, order("created_at DESC")
  scope :by_type, lambda { |param| where{ type.like param } unless param.nil? }
  scope :since, lambda { |date| where{ created_at.gt Time.at(date+1) } unless date.nil? }

  before_save :set_original_created_at

  def self.by_type_and_date(type=nil)
    by_type(type).by_date.includes(:meta_data).includes(:user)
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

  def can_be_regrowled?(user)
    user.can_regrowl?(self) if user
  end

  def build_regrowl_for(new_user)
    if can_be_regrowled?(new_user)
      new_regrowl = self.dup
      id = regrowled_from_id if regrowled_from_id # Credits original owner
      new_regrowl.attributes = { user_id: new_user.id, regrowled_from_id: id }
      new_regrowl
    end
  end

  # def self.regrowled_new(growl_id, user_id)
  #   growl = Growl.find(growl_id).dup
  #   if growl && growl.user_id != user_id
  #     growl.user_id = user_id
  #     growl.regrowled_from_id = growl_id
  #     growl.save
  #   end
  # end

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
    original_growl? ? user : original_growl.user
  end

  def get_display_name
    get_user.display_name
  end

  def get_gravatar
    get_user.avatar
  end

  def original_growl
    regrowled? ? Growl.find(regrowled_from_id) : self
  end

  private

  def set_original_created_at
   self.original_created_at = DateTime.now unless original_created_at
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
#  regrowled_from_id   :integer
#  original_created_at :datetime
#  event_type          :string(255)
#

