class DashboardController < ApplicationController
  def show
    @text_item = TextItem.new
  end
end
