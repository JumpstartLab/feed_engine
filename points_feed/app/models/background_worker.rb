 class BackgroundWorker

  def self.import_from_twitter
    Resque.enqueue(TwitterImporter)
  end

  def self.import_from_github
    Resque.enqueue(GithubImporter)
  end

end