class Post < ActiveRecord::Base
  attr_accessible :comment, :title, :content

  validates :comment, :length => { :maximum => 256 }
  validates_presence_of :content

  def self.new_with_type(params)
    post = Post.new(:type => params[:type])
    post.save
    post = Post.find(post.id)
    post.update_attributes(params)
    post
  end

end
