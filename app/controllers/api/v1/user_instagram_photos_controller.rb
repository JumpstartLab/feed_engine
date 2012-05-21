class Api::V1::UserInstagramPhotosController < Api::V1::ApiController
  before_filter :verify_instagram_account

  def create
    photos = JSON.parse(params["photos"])
    photos.each do |photo|
      @user.photos.create(link: photo["link"],
                          comment: photo["comment"],
                          original_created_at: photo["created_at"])
      @user.instagram_account.update_last_status_id_if_neccessary(photo["created_at"])
    end
    render :json => true, :status => 201
  end

private

  def verify_instagram_account
    @user = User.where(id: params["user_id"]).first
    unless @user
      render :json => "User account cannot be found.", :status => 500
    end
  end
end
