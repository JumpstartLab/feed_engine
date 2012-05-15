class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :new, :create]
  
  def show
    @user = User.find_by_subdomain!(request.subdomain)
    @posts = @user.posts
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
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

    respond_to do |format|
      if @user.save
        format.html { sign_in_and_redirect @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
end
