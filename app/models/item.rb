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

  has_one :message, :as => :post
  has_one :image, :as => :post
  has_one :link, :as => :post

  def poster
    User.where(id: poster_id)
  end

  def post
    Kernel.const_get(self.post_type.capitalize).find(post_id)
  end

  def self.page_count(page_size=10)
    @items_page_count ||= begin
      pages, rem = Item.all.count.divmod(page_size)
      pages += 1 if rem > 0
      pages
    end
  end
end
