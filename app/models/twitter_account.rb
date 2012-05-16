class TwitterAccount < ActiveRecord::Base
  belongs_to :authentication
  has_one :user, :through => :authentication
  attr_accessible :authentication, :uid, :nickname, :last_status_id, :image

  def user_id
    user.id
  end
end
