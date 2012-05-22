class Api::PostsController < Api::ApiController
  before_filter :authenticate_user!, :except => :show

  def create
    type = params[:type] || params[:post][:type]
    post = @current_user.relation_for(type).new(params[:post])
    if post.save
      success(201)
    else
      validation_error(post)
    end
  end

  def show
    post = Post.where(:id => params[:id]).first
    unless post.nil?
      render :json => post.decorator
    else
      error(400)
    end
  end

end
