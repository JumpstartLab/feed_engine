class UserSignupStepsController < ApplicationController
  include Wicked::Wizard
  steps :twitter, :github, :instagram

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    render_wizard @user
  end

  def finish
    redirect_to dashboard_path, notice: "Welcome to Feedonkulous!"
  end

end
