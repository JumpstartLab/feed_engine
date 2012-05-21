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
  attr_accessible :post_id, :post_type, :poster_id, :refeed
  after_destroy :destroy_refeeds!
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
    User.find(self.poster_id)
  end

  def post
    self.post_type.constantize.find(post_id)
  end

  def refeed_for(new_poster)
    if new_poster.id == poster_id
      raise ArgumentError, "User's can't refeed their own items."
    else
      new_attributes = {
        poster_id: new_poster.id,
          post_id: self.post_id,
        post_type: self.post_type,
           refeed: true
      }
      Item.create(new_attributes)
    end
  end

  def refeed?
    refeed
  end

  private

  def destroy_refeeds!
    Item.find_all_by_post_id(post_id).map(&:destroy)
  end
end
