module GetLatestInstagrams
  @queue = :instagrams_low
  def self.perform()
    Authentication.find_all_by_provider("instagram").each do |auth|
      Instagram.import_posts(auth.user.id)
    end    
  end
end