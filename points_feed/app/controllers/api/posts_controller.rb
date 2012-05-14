class Api::PostsController < Api::ApiController
  before_filter :authenticate_user!

  def create
    # @current_user.new_child_of(type, params) 
    type = params[:type] || params[:post][:type]
    post = @current_user.relation_for(type).new(params[:post])
    if post.save
      success(201)
    else
      validation_error(post)
    end
  end

end
