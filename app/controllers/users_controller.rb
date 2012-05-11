# The controller for a user - creating and editing accounts and showing posts
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by_display_name(request.subdomain)

    if @user
      @posts = Kaminari.paginate_array(
                          @user.sorted_posts
                        ).page(params[:page]).per(12)
    else
      redirect_to root_url(:host => request.domain),
        :notice => "User #{request.subdomain} not found."
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login_and_notify_user
      redirect_to dashboard_path, notice: "Thank you for signing up!"
    else
      retain_password
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to dashboard_path, notice: "Password changed"
    else
      @message, @image, @link = Message.new, Image.new, Link.new
      retain_password
      render "dashboard/show"
    end
  end

  private

  def retain_password
    @password = params[:user][:password]
    @password_confirmation = params[:user][:password_confirmation]
  end

  def login_and_notify_user
    session[:user_id] = @user.id
    @user.send_welcome_email
  end

  def set_user_from_subdomain
  end
end
