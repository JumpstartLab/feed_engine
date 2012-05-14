class Api::PostsController < Api::ApiController
  before_filter :authenticate_user!

  def create
    type = params[:type] || params[:post][:type]
    post = @current_user.relation_for(type).new(params[:post])
    if post.save
      success()
    else
      validation_error(post)
    end
  end

end
