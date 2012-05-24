# == Schema Information
#
# Table name: twitter_posts
#
#  id           :integer         not null, primary key
#  twitter_id   :string(255)
#  text         :string(255)
#  published_at :datetime
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class TwitterPost < ActiveRecord::Base
  attr_accessible :published_at, :text, :twitter_id, :created_at
  has_one :post, :as => :postable, dependent: :destroy
  has_one :user, :through => :post
end
