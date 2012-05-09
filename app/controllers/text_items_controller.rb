class TextItemsController < ApplicationController
  def create
    @text_item = TextItem.new(params[:text_item])

    respond_to do |format|
      if @text_item.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { redirect_to dashboard_path, alert: "Post is invalid" }
      end
    end
  end
end
