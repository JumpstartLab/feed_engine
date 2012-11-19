require "open-uri"

class Growl < ActiveRecord::Base
  attr_accessible :comment, :link, :user, :type,
                  :external_id, :original_created_at,
                  :user_id, :event_type, :regrowled_from_id

  validates_presence_of :type, :user_id, :user_id
  validates_uniqueness_of :regrowled_from_id, :allow_nil => true,
                          :scope => :user_id

  belongs_to :user
  has_one :meta_data, :autosave => true, dependent: :destroy
  has_many :regrowls
  include HasUploadedFile

  scope :by_date, order("original_created_at DESC")
  scope :where_original, where(regrowled_from_id: nil)
  scope :by_type, lambda { |param| where{ type.like param } unless param.nil? }

  before_save :set_original_created_at
  before_save :add_trend

  def self.since
    where{ created_at.gt Time.at(epoch) } unless epoch.nil?
  end

  def self.by_type_and_date(type=nil)
    by_type(type).by_date.includes(:meta_data).includes(:user)
  end

  ["title", "thumbnail_url", "description"].each do |method|
    define_method method.to_sym do
      meta_data ? meta_data.send(method.to_sym) : ""
    end
  end

  ["link", "message", "image", "video"].each do |method|
     define_method "#{method}?".to_sym do
        self.type == method.capitalize
    end
  end

  def belongs_to?(user)
    user_id == user.id
  end

  def already_regrowled_by?(user)
    user.growls.where(regrowled_from_id: id).present?
  end

  def original_poster?(user)
    get_original_user.id == user.id
  end

  def can_be_regrowled?(user)
    user.can_regrowl?(self) if user
  end

  def build_regrowl_for(new_user)
    if can_be_regrowled?(new_user)
      self.set_regrowl_attributes(new_user)
    end
  end

  def set_regrowl_attributes(new_user)
    new_regrowl = self.dup
    new_regrowl.meta_data = self.meta_data.dup if self.meta_data
    new_id = regrowled_from_id || id
    new_regrowl.attributes = { user_id: new_user.id, regrowled_from_id: new_id }
    new_regrowl
  end

  def regrowled?
    regrowled_from_id.present?
  end

  def regrowl_link(request)
    if regrowled?
      "http://api.#{request.domain}/feeds/#{get_original_user.slug}/growls/" + 
        "#{original_growl.id}"
    else
      ""
    end
  end

  def get_original_user
    original_growl? ? user : original_growl.user
  end

  def get_display_name
    get_original_user.display_name.capitalize
  end

  def get_gravatar
    get_original_user.avatar
  end

  def original_growl
    regrowled? ? Growl.find(regrowled_from_id) : self
  end

  def original_growl?
    !regrowled?
  end

  def parse_hashtags
    hashtags = comment.scan(/\B#(\S+)/).uniq
    hashtags.collect { |service| service.first.downcase }
  end

  def add_trend
    hashtags = parse_hashtags
    hashtags.delete("twitter")
    hashtags.each { |hashtag| Topic.create(name: hashtag, user: user) }
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

