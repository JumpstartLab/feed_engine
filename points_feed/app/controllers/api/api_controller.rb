class Api::ApiController < ActionController::Base
  respond_to :json, :xml
  # rescue_from Exception, :with => :validation_exception

  private

  # def validation_exception(e)
  #   render :json => e
  # end

  def validation_error(obj)
    error(406, obj.errors.full_messages)
  end

  def success(code=200)
    render :status => code, :json => true
  end

  def error(code, msg="")
    render :status => code, :json => msg
  end

  def current_user
    token = params[:access_token]
    @current_user ||= User.where(:authentication_token => token).first
  end

  def authenticate_user!
    error(403) unless current_user
  end
end