# == Schema Information
#
# Table name: text_posts
#
#  id         :integer         not null, primary key
#  text       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class TextPost < ActiveRecord::Base
  attr_accessible :text, :created_at, :updated_at, :user_id

  validates_length_of :text, within: 1..512

  # after_create :create_post

  # has_one :post#, :as => :feed
  # has_one :user#, :through => :post

  has_one :post, :as => :postable, dependent: :destroy
  has_one :user, :through => :post

  def create_post
    Post.new()
  end

  def self.user
    post.user
  end
end
