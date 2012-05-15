class GithubJob
  @queue = :gist

  def self.perform(current_user, authentication)
    raise "BOOM"
  end
end
