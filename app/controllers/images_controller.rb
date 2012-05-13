class ImagesController < ApplicationController
  before_filter :authenticate_user!

  # def new
  #   @image = Image.new
  # end

  # def create
  #   @image = current_user.images.new_image(params[:image])
  #   if @image.save
  #     redirect_to dashboard_path, :notice => "Image posted succesfully."
  #   else
  #     flash[:alert] = "There was an error saving this image. See below for details."
  #     render 'new'
  #   end
  # end
end