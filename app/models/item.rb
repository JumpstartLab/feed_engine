class Item < ActiveRecord::Base
  attr_accessible :post_id, :user_id

  belongs_to :user

  has_many :messages, :as => :posts
  has_many :images, :as => :posts
  has_many :links, :as => :posts

  validates_presence_of :user_id
end
