class PostsController < ApplicationController

def new
  post = Post.new
end

def create
  post = Post.new_with_type(params[:post])
  if post.save?
  else
  end
      

end

end
