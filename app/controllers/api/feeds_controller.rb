class Api::FeedsController < Api::BaseController
  def show
    @user = User.where("display_name ILIKE ?", subdomain_username).first
    @stream_items = @user.stream_items.order("created_at DESC").page(params[:page]).per(12)
  end
end
