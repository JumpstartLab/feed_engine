class TwitterAccount < ActiveRecord::Base
  belongs_to :authentication
  has_one :user, :through => :authentication
  attr_accessible :authentication, :uid, :nickname, :last_status_id, :image

  def user_id
    user.id
  end

  def update_last_status_id_if_necessary(new_status_id)
    if last_status_id.to_f < new_status_id.to_f
      update_attribute("last_status_id", tweet["status_id"])
    end
  end

end
