class PagesController < ApplicationController
  def index
    @users = User.all
  end
end
