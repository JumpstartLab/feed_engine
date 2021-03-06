# == Schema Information
#
# Table name: text_posts
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  title      :string(255)
#  body       :text


class TextPost < ActiveRecord::Base
  attr_accessible :body, :created_at, :updated_at, :user_id, :title

  validates_length_of :body, within: 1..512

  # after_create :create_post

  has_one :post, :as => :postable, dependent: :destroy
  has_one :user, :through => :post

  def create_post
    Post.new()
  end
end
