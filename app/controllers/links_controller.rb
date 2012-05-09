class LinksController < ApplicationController
  before_filter :authenticate_user!

  def new
    @link = Link.new
  end

  def create
    @link = current_user.images.new(params[:link])
    if @link.save
      redirect_to dashboard_path, :notice => "Link posted succesfully."
    else
      flash[:alert] = "There was an error."
      render 'new'
    end
  end

end
