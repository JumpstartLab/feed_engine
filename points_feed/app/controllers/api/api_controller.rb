class Api::ApiController < ActionController::Base
  respond_to :json, :xml

  def validation_error(obj)
    error(406, obj.errors.full_messages)
  end

  def success(code=201)
    render :status => code, :json => true
  end

  def error(code, msg="")
    render :status => code, :json => msg
  end

  def authenticate_user
    @current_user = User.where(:authentication_token => params[:access_token]).first
  end

  def authenticate_user!
    authenticate_user
    error(403) if @current_user.nil? or params[:access_token].blank?
  end
end