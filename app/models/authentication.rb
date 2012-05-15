class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :token, :secret
  #attr_accessor :provider, :token, :secret

  belongs_to :user

  def create_with_omniauth(auth)
    self.update_attributes(provider: auth["provider"],
                           token: auth["credentials"]["token"],
                           secret: auth["credentials"]["secret"])
  end
end
