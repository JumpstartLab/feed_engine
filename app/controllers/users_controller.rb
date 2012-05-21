# The controller for a user - creating and editing accounts and showing posts
class UsersController < ApplicationController
  after_filter :send_welcome_email, only: :create
  before_filter :remove_point_pending, only: :show

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_subdomain(request.subdomain)

    if @user
      @posts = Kaminari.paginate_array(
        @user.sorted_posts
      ).page(params[:page]).per(12)
    else
      redirect_to root_url(:host => request.domain)
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      create_user_session
      add_point(session[:point_pending_for]) if session[:point_pending_for]
      redirect_to new_subscription_path
    else
      retain_password
      render "new"
    end
  end

  def update
    @link, @image, @message = Link.new, Image.new, Message.new

    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to dashboard_path, notice: "Password changed"
    else
      retain_password
      render "dashboard/show"
    end
  end

  private

  def retain_password
    @password = params[:user][:password]
    @password_confirmation = params[:user][:password_confirmation]
  end

  def send_welcome_email
    @user.send_welcome_email
  end
end
