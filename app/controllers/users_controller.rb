class UsersController < ApplicationController
  before_filter :require_login, except: [:show, :new, :create]
  
  def show
    @user = User.find_by_subdomain!(request.subdomain)
    @posts = @user.posts
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = current_user
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

  def signout
    sign_out current_user
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
