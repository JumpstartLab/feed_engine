class API::V1::UserGithubEventsController < API::V1::APIController
  before_filter :verify_github_account

  def created
    events = JSON.parse(params["github_events"])

    events.each do |event|
      @user.github_events.create(event_type: event["event_type"],
                          link: event["link"],
                          original_created_at: event["created_at"],
                          comment: event["comment"])
      @user.github_account.update_last_status_id_if_necessary(event["created_at"])
    end
    render :json => true, :status => 201
  end

  private

  def verify_github_account
    @user = User.where(id: params["user_id"]).first
    unless @user
      render :json => "User account can not be found.", :status => 500
    end
  end
end
