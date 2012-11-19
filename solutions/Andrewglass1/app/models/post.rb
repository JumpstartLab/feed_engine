class Post < ActiveRecord::Base
  attr_accessible :feed_id
  belongs_to :postable, :polymorphic => true
  belongs_to :feed
  has_many :points
end