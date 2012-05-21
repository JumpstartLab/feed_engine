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
#  last_status_id :integer(8)
#  image          :string(255)
#

class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :token,
                  :secret, :uid, :username, :last_status_id,
                  :image

  belongs_to :user
  after_create :import_items

  def create_with_omniauth(auth)
    self.update_attributes(provider: auth["provider"],
                           token: auth["credentials"]["token"],
                           secret: auth["credentials"]["secret"],
                           uid: auth["uid"],
                           username: auth["info"]["nickname"])
    save!
  end

  def create_twitter_auth(omniauth)
    self.update_attributes(provider: omniauth["provider"],
                           token: omniauth["credentials"]["token"],
                           secret: omniauth["credentials"]["secret"],
                           uid: omniauth["uid"],
                           username: omniauth["info"]["nickname"],
                           last_status_id: omniauth["extra"]["raw_info"]["status"]["id_str"],
                           image: omniauth["info"]["image"]
      )
    save!
  end
  
  def create_github_auth(omniauth)
    self.update_attributes(provider: omniauth["provider"],
                           token: omniauth["credentials"]["token"],
                           secret: omniauth["credentials"]["secret"],
                           uid: omniauth["uid"],
                           username: omniauth["info"]["nickname"],
                           last_status_id: omniauth["extra"]["raw_info"]["status"]["id_str"],
                           image: omniauth["extra"]["raw_info"]["avatar_url"]
      )
    save!
  end

  def import_items
    case self.provider
    when "twitter"
      Fetcher.delay.fetch_and_import_tweets(self.uid, self.user_id, self.last_status_id)
    else
    Fetcher.import_items(self.provider, self.uid, self.user_id, self.username, self.last_status_id)
    end
  end
end
