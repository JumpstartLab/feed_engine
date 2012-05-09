class UsersController < ApplicationController
  def new
    raise 'Boom!'
    @user = User.new
  end


end
