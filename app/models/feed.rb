class Feed < ActiveRecord::Base
  attr_accessible :user_id, :private, :name, :link

  belongs_to :user
  has_many :posts

  # def set_name(name)
  #   self.name = name
  #   self.save
  # end

  # def private?
  #   self.private
  # end
end
