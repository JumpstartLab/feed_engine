class Authentication < ActiveRecord::Base
  attr_accessible :create, :destroy, :index, :provider, :uid, :user_id

  belongs_to :user

  def self.find_or_create_by_auth( auth )
    user = User.find_or_create_by_uid( auth['uid'] )

    user.name       = auth['info']['name']
    user.twitter    = auth['info']['nickname']
    user.url        = auth['info']['urls']['Website']
    user.bio        = auth['info']['description']
    user.avatar_url = auth['info']['image']

    user.save!

    return user
  end

end
