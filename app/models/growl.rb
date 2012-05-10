class Growl < ActiveRecord::Base
  attr_accessible :comment, :link, :user

  validates_presence_of :type
  after_create :get_meta_data
  belongs_to :user
  has_one :meta_data
  accepts_nested_attributes_for :meta_data
  def self.for_user(display_name)
    user = User.where{username.matches display_name}.first
    user.growls
  end

  def get_meta_data
    # do stiuff here to get meta
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
#  id         :integer         not null, primary key
#  type       :string(255)
#  comment    :text
#  link       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#