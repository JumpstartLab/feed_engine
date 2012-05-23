class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if session[:post_id] && session[:receiver_id]
      Point.create(post_id: session[:post_id],
                   receiver_id: session[:receiver_id],
                   giver_id: current_user.id)
      redirect_to session[:page_before_sign_in]
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end

  def destroy
    destroy_post_receiver_and_before_page_session
    super
  end

  private

  def destroy_post_receiver_and_before_page_session
    session[:post_id] = nil
    session[:receiver_id] = nil
    session[:page_before_sign_in] = nil
  end
end
