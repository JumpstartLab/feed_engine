# == Schema Information
#
# Table name: items
#
#  id                 :integer         not null, primary key
#  poster_id          :integer
#  post_id            :integer
#  post_type          :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  refeed             :boolean
#  original_poster_id :integer
#

# An item is a uniquely identifiable post in our system.
class Item < ActiveRecord::Base
  attr_accessible :post_id, :post_type, :poster_id, :refeed, :original_poster_id
  after_destroy :destroy_refeeds!
  belongs_to :post, :polymorphic => true

  def self.all_items_sorted_posts
    items = Item.order("created_at desc").includes(:post => [:user, :item])
    posts = items.reject(&:refeed?).collect(&:post)
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
    raise NotRefeedable, "Can't refeed item" unless refeedable_for?(new_poster)

    new_attributes = {
      poster_id: new_poster.id,
      post_id: self.post_id,
      post_type: self.post_type,
      refeed: true,
      original_poster_id: self.poster_id
    }
    Item.create(new_attributes)
  end

  def refeed?
    refeed
  end

  def refeedable_for?(user)
    refed_item = Item.find_by_poster_id_and_post_id_and_post_type(user.id,
                                                                  post.id,
                                                                  post_type)
    refed_item.nil? && user.id != poster_id
  end

  private

  def destroy_refeeds!
    Item.find_all_by_post_id(post_id).map(&:destroy)
  end

  # This error is raised when a user refeeds their own item or already refed
  # the item they are trying to refeed
  class NotRefeedable < ArgumentError; end
end
