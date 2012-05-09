class DashboardsController < ApplicationController
  def show
    @post = TextPost.new
  end
end
