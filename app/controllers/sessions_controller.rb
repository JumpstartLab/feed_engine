class SessionsController < ApplicationController
  def new
  end

  def create
    login(params[:email], params[:password])
  end

  def destroy
    logout
  end
end
