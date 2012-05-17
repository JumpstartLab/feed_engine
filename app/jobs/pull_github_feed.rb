require './app/lib/tweet_processor'

class PullGithubFeed
  @queue = :github

  def self.perform
    github_processor = Hungrlr::GithubProcessor.new
    github_processor.run
  end
end
