class Post < ActiveRecord::Base
  attr_accessible :comment, :content, :type, :file
  belongs_to :user
  mount_uploader :file, FileUploader
  
  validates_presence_of :user_id
  validates :comment, :length => { :maximum => 256 }


  default_scope :order => 'created_at DESC'

  def posted_at
    self.created_at
  end

  # def self.class_for(type)
  #   type.to_s.constantize rescue TextPost
  # end

end
