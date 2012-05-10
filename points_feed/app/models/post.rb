class Post < ActiveRecord::Base
  attr_accessible :comment, :title, :content, :type
  belongs_to :user
  
  validates_presence_of :user_id
  validates :comment, :length => { :maximum => 256 }
  validates_presence_of :content

  default_scope :order => 'created_at DESC'

  # def self.class_for(type)
  #   type.to_s.constantize rescue TextPost
  # end

end
