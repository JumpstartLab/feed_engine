class Subscription < ActiveRecord::Base
  attr_accessible :user_name, :provider, :uid, :user_id

  belongs_to :user

  def self.create_with_omniauth(auth, user)
    create! do |subscription|
      subscription.provider = auth["provider"]
      subscription.uid = auth["uid"]
      subscription.user_name = auth["info"]["nickname"]
      subscription.user_id = user.id
    end
  end
end
