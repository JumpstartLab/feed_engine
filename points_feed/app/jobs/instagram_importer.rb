class InstagramImporter
  @queue = :medium

  def self.perform
   authentications_with_instagram.each do |auth|
     import_instagram(auth)
   end
  end

  private

  def self.authentications_with_instagram
    Authentication.joins("JOIN users ON users.id == user_id")
                  .where("user_id is NOT NULL and provider is ?", "instagram")
                  .includes("user")
  end

  def self.connection
    connection = Faraday.new(:url => "https://api.instagram.com/v1")
  end

  def self.con
    self.connection
  end

  def self.import_instagram(auth)
    resp = con.get("users/#{auth.uid}/media/recent?access_token=#{auth.secret}")
    resp = JSON.parse(resp.body)
    instagrams = Hashie::Mash.new(resp)
    instagrams.data.each do |instagram|
      InstagramFeedItem.import(auth.user, instagram)
    end
  end

end