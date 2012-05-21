class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      redirect_to user_signup_steps_path
      flash[:notice] = "Welcome! You have signed up successfully."
    else
      render :new
    end
  end

  def update
    super
  end
end
