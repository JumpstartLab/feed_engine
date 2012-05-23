class Api::V1::GrowlsController < Api::V1::ApiController

  def show
    growl = Growl.find(params[:id])
    render :json => growl
  end

  def index
    @user = User.where(display_name: params[:display_name]).first
    @growls = @user.growls.by_date.page(params[:page]).per(10)
  end

  def create
    json_hash = JSON.parse(params[:body])
    @growl = current_user.relation_for(json_hash["type"]).new(json_hash)

    if @growl.save
      render :json => @growl, status: :created
    else
      @errors = @growl.errors.collect { |k,v| v }
      render 'api/v1/shared/errors', status: :not_acceptable
    end
  end

  def destroy
    Growl.find(params[:id]).destroy
    render :json => true, status: :created
  end

end
