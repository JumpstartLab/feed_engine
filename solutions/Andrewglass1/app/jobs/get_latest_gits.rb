module GetLatestGits
  @queue = :gits_low
  def self.perform()
    Authentication.find_all_by_provider("github").each do |auth|
      Githubevent.import_posts(auth.user.id)
    end
  end
end