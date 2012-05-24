class FeedsController < ApplicationController
  respond_to :xml, :json

  def index
  end

  def show
    @user = current_user
  end

end
