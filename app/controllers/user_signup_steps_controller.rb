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

private

  def redirect_to_finish_wizard
    redirect_to dashboard_path, notice: "Thank you for signing up."
  end

end
