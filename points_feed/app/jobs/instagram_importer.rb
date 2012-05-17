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


  def self.import_instagram(auth)
    media = connection.get("users/#{auth.uid}/media/recent?access_token=#{auth.secret}")
    media = JSON.parse(media.body)
    instagrams = Hashie::Mash.new(media)
    instagrams.data.each do |instagram|
      InstagramFeedItem.import(auth.user, instagram)
    end
  end





  # def self.pretty_hash(hash)
  #   results = []
  #   hash.keys.each do |key|
  #     results << key
  #     if hash[key].respond_to?(:keys)
  #       results << pretty_hash(hash[key]).split("\n").map do | line |
  #         " -- " + line
  #       end
  #     end
  #   end
  #   results.join("\n")
  # end
end