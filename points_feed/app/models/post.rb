class Post < ActiveRecord::Base
  attr_accessible :comment, :title, :content, :type

  validates :comment, :length => { :maximum => 256 }
  validates_presence_of :content

  def self.class_for(type)
    type.to_s.constantize rescue TextPost
  end

end
