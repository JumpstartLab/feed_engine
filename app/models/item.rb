class Item < ActiveRecord::Base
  attr_accessible :poster_id, :post_id, :post_type

  has_many :messages, :as => :posts
  has_many :images, :as => :posts
  has_many :links, :as => :posts
end
