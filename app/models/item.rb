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

  def poster
    User.where(id: poster_id)
  end

  def post  
    self.post_type.capitalize.constantize.find(post_id)  
  end
end
