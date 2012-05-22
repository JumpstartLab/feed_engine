class Api::V1::FeedsController < Api::V1::ApiController

  def show
    @user = User.where(display_name: params[:display_name]).first
    if params[:since].blank?
      @recent_growls = @user.growls.by_date.limit(3)
    else
      @recent_growls = @user.growls.since(params[:since].to_i).by_date
    end
  end

  #XXX SHOULD BE MOVED TO A REGROWL CONTROLLER
  def refeed
    growl = Growl.find(params[:id])
    if growl && growl.build_regrowl_for(@current_user).try(:save)
      render status: :created, json: "Regrowl successful"
    else
      render status: :bad_request, json: "This item cannot be regrowled."
    end
  end

  def destroy_refeed
    @current_user.growls.where(regrowled_from_id: params[:id]).first.destroy
    render status: :created, json: "Regrowl Destroyed"
  end

  def subscriber_refeed
    user = User.where(display_name: params[:display_name]).first
    growls = JSON.parse(params[:growls])
    growls.each do |growl|
      Growl.where(id: growl["id"]).first.build_regrowl_for(user).try(:save)
    end
    render status: :created, json: "Regrowling complete"
  end

end