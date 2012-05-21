class Authentication < ActiveRecord::Base
  attr_accessible :user, :token, :secret, :provider
  belongs_to :user
  has_one :twitter_account
  has_one :github_account

  SERVICES = ["twitter", "github", "instagram"]

  SERVICES.each do |service|
    define_singleton_method "#{service}".to_sym do
      where(provider: service).first
    end

    define_singleton_method "#{service}?".to_sym do
      where(provider: service).size > 0 ? true : false
    end

    # define_singleton_method "add_#{service}".to_sym do
    # end
  end

  def self.add_twitter(user, data)
    auth = create_twitter_auth(user, data)
    auth && auth.create_twitter_details(data)
  end

  def self.add_github(user, data)
    auth = create_github_auth(user, data)
    auth && auth.create_github_details(data)
  end

  def self.add_instagram(user, data)
    auth = create_instagram_auth(user, data)
    auth && auth.create_instagram_details(data)
  end

  def self.create_twitter_auth(user, data)
    user.authentications.create(provider: data["provider"],
                                token: data["credentials"]["token"],
                                secret: data["credentials"]["secret"])
  end

  def create_twitter_details(data)
    create_twitter_account(uid: data["uid"],
                           nickname: data["info"]["nickname"],
                           image: data["info"]["image"],
                           last_status_id: data["extra"]["raw_info"]["status"]["id_str"])
  end

  def self.create_github_auth(user, data)
    user.authentications.create(provider: data["provider"],
                                token: data["credentials"]["token"])
  end

  def create_github_details(data)
    create_github_account(uid: data["uid"],
                           nickname: data["info"]["nickname"],
                           image: data["extra"]["raw_info"]["avatar_url"],
                           last_status_id: DateTime.now)
  end

  def self.create_instagram_auth(user, data)
    user.authentications.create(provider: data["provider"],
                                token: data["credentials"]["token"])
  end

  def create_instagram_details(data)
    create_instagram_account(uid: data["uid"],
                             nickname: data["info"]["nickname"],
                             image: data["info"]["image"],
                             last_status_id: DateTime.now)
  end
end
# == Schema Information
#
# Table name: authentications
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  token      :string(255)
#  secret     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

