class GithubFeeder
  @queue = :github_queue
  def self.perform(user_id)
    Githubevent.import_posts(user_id)
  end
end