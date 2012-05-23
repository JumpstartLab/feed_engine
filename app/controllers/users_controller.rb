class UsersController < ApplicationController
  before_filter :require_login, except: [:show, :new, :create, :reset_password]
  
  def show
    @user = User.find_by_subdomain!(request.subdomain)
    @posts = @user.posts
  end

  def create
    @user = User.create(params[:user])
    render_create
  end

  def update
    @user = current_user
    @user.update_password(params[:user])
    render_create
  end

  def reset_password
    if @user = User.find_by_email(params[:email])
      @user.reset_password
    end
  end

  private
  def render_create
    unless @user.errors.any?
      render "create",
      :status => :ok,
      :handlers => [:jbuilder]
    else
      render "create",
      :status => :unprocessable_entity,
      :handlers => [:jbuilder]
    end
  end
end
