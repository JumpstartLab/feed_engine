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
    @user = User.new(params[:user])
    if @user.save
      auto_login @user
    end
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def signin
    if @user = User.find(params[:user])
      sign_in @user
    else
      @user.errors << "Login failed, please try again"
    end
  end

  def signout
    sign_out current_user
  end
end
