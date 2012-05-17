class Api::V1::GrowlsController < Api::V1::ApiController

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

end
