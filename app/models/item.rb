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
#  refeed     :boolean
#

# An item is a uniquely identifiable post in our system.
class Item < ActiveRecord::Base
  attr_accessible :post_id, :post_type, :poster_id, :refeed
  after_destroy :destroy_refeeds!
  belongs_to :post, :polymorphic => true

  def self.all_items_sorted_posts
    Item.order("created_at desc").includes(:post => [:user, :item]).collect(&:post)
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

  def refeed_for(new_poster)
    if refeedable_for?(new_poster)
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

  def refeedable_for?(user)
    refed_item = Item.find_by_poster_id_and_post_id(user.id, post.id)
    refed_item.nil? && user.id != poster_id
  end

  private

  def destroy_refeeds!
    Item.find_all_by_post_id(post_id).map(&:destroy)
  end
end
