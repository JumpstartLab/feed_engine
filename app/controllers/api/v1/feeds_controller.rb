class Api::V1::FeedsController < Api::V1::ApiController

  def show
    @user = User.find_by_display_name(params[:display_name])
    if params[:since].blank?
      @recent_growls = @user.growls.by_date.limit(3)
    else
      @recent_growls = @user.growls.since(params[:since].to_i).by_date
    end
  end

  def create
    json_hash = JSON.parse(params[:body])
    @growl = current_user.relation_for(json_hash["type"]).new(json_hash)

    if @growl.save
      render location: @growl, status: :created
    else
      @errors = @growl.errors.collect { |k,v| v }
      render 'create', status: :not_acceptable
    end
  end

  def refeed
    growl = Growl.find(params[:id])
    if growl.regrowled(@current_user.id)
      render status: :created, json: "Refeed Successful"
    else
      render status: :bad_request, json: "You can't regrowl yourself!"
    end
  end
  
end
