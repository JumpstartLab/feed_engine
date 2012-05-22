# == Schema Information
#
# Table name: authentications
#
#  id             :integer         not null, primary key
#  user_id        :integer
#  provider       :string(255)
#  token          :string(255)
#  secret         :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  uid            :string(255)
#  username       :string(255)
#  last_status_id :string(255)
#  image          :string(255)
#

class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :token,
                  :secret, :uid, :username, :last_status_id,
                  :image

  belongs_to :user
  after_create :import_items

  def create_twitter_auth(omniauth)
    self.update_attributes(provider: omniauth["provider"],
                           token: omniauth["credentials"]["token"],
                           secret: omniauth["credentials"]["secret"],
                           uid: omniauth["uid"],
                           username: omniauth["info"]["nickname"],
                           last_status_id: omniauth["extra"]["raw_info"]["status"]["id_str"],
                           image: omniauth["info"]["image"]
      )
  end

  def create_github_auth(omniauth)
    self.update_attributes(provider: omniauth["provider"],
                           token: omniauth["credentials"]["token"],
                           secret: omniauth["credentials"]["secret"],
                           uid: omniauth["uid"],
                           username: omniauth["info"]["nickname"],
                           last_status_id: DateTime.now.to_s,
                           image: omniauth["extra"]["raw_info"]["avatar_url"]
      )
  end

  def create_instagram_auth(omniauth)
    self.update_attributes(provider: omniauth["provider"],
                           token: omniauth["credentials"]["token"],
                           secret: omniauth["credentials"]["secret"],
                           uid: omniauth["uid"],
                           username: omniauth["info"]["nickname"],
                           last_status_id: DateTime.now.to_s,
                           image: omniauth["info"]["image"]
      )
  end

  def import_items
    case self.provider
    when 'twitter'
      Fetcher.delay.import_twitter_activity(self.uid, self.user, self.last_status_id)
    when 'github'
      Fetcher.delay.import_github_activity(self.username, self.user, self.last_status_id)
    end
  end
end
