class GithubImporter
  @queue = :medium

  def self.perform
   authentications_with_github.each do |auth|
     import_events(auth)
   end
  end

  private

  def self.authentications_with_github
    Authentication.joins("JOIN users ON users.id == user_id")
                  .where("user_id is NOT NULL and provider is ?", "github")
                  .includes("user")
  end

  def self.import_events(authentication)
    Octokit.user_events(authentication.login).each do |event|
      GithubFeedItem.import(authentication.user, event)
    end
  end

  def self.pretty_hash(hash)
    results = []
    hash.keys.each do |key|
      results << key
      if hash[key].respond_to?(:keys)
        results << pretty_hash(hash[key]).split("\n").map do | line |
          " -- " + line
        end
      end
    end
    results.join("\n")
  end
end