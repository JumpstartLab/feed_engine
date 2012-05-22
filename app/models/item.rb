# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  poster_id  :integer
#  post_id    :integer
#  post_type  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# An item is a uniquely identifiable post in our system.
class Item < ActiveRecord::Base
  attr_accessible :post_id, :post_type, :poster_id

  belongs_to :post, :polymorphic => true

  def self.all_items
    User.all.collect { |user| user.items }.flatten(1)
  end

  def self.all_items_sorted
    all_items.sort do |comparer, comparee|
      comparee.created_at <=> comparer.created_at
    end
  end

  def self.all_items_sorted_posts
    all_items_sorted.collect { |item| item.post }
  end

  def self.give_point_to(item_id)
    item = Item.find(item_id)
    post_type = item.post_type.constantize
    post = post_type.find(item.post_id)
    post.increase_point_count
  end

  def poster
    User.where(id: poster_id)
  end

  def post
    if self.post_type == "GithubEvent"
      GithubEvent.find(post_id)
    else
      self.post_type.capitalize.constantize.find(post_id)
    end
  end
end
