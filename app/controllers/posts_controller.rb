class PostsController < ApplicationController
  has_scope :page, :default => 1
  
  def create
    klass_name = params[:type]
    params[klass_name][:user_id] = current_user.id
    klass = Module.const_get(klass_name.capitalize)
    @post = klass.create(params[klass_name])
    unless @post.errors.any?
      render "create",
              :status => :ok,
              :handlers => [:jbuilder]
    else
      render "create",
              :status => :unprocessable_entity,
              :handlers => [:jbuilder]
    end
  end

  def index
    @posts = Post.all.page(params[:page])
  end
end
