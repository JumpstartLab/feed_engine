class Post < ActiveRecord::Base
  attr_accessible :comment, :content, :type, :file, :original_post_id
  belongs_to :user
  mount_uploader :file, FileUploader
  
  validates_presence_of :user_id
  validates :comment, :length => { :maximum => 256 }

  after_create :set_original_post_id

  default_scope :order => 'created_at DESC'

  def set_original_post_id
    update_attribute(:original_post_id, self.id) unless self.original_post_id
  end

  def posted_at
    self.created_at
  end

  def refeed(user)
    refeeded_post = self.dup
    user.posts << refeeded_post
    refeeded_post.update_attribute(:original_post_id, self.original_post_id)
  end

  def original_post
    Post.find(original_post_id)
  end

  def attributed_user
    original_post.user
  end

  # def self.class_for(type)
  #   type.to_s.constantize rescue TextPost
  # end

end
