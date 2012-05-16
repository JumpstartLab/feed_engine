# == Schema Information
#
# Table name: twitter_posts
#
#  id           :integer         not null, primary key
#  twitter_id   :integer
#  text         :string(255)
#  published_at :datetime
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class TwitterPost < ActiveRecord::Base
  attr_accessible :published_at, :text, :twitter_id, :created_at
  has_one :post, :as => :postable, dependent: :destroy
  has_one :user, :through => :post
   
  validates_uniqueness_of :twitter_id

end