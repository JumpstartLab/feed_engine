class UsersController < ApplicationController
  respond_to :html, :json

  def show
    @posts = user.posts.order("created_at DESC").limit(7)
    @posts = @posts.offset((params[:page].to_i-1)*7) if params[:page].present?
    respond_with @posts
  end

  def twitter
    omniauth = request.env["omniauth.auth"]
    auth = current_user.authentications.find_or_initialize_by_provider(omniauth["provider"])
    if auth.create_with_omniauth(omniauth)
      redirect_to dashboard_url(subdomain: false), 
        notice: "Twitter account connected!"
    else
      redirect_to dashboard_url(subdomain: false), 
        notice: "Something went wrong connecting to Twitter! Please try again!"
    end
  end

end
