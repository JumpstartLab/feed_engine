 class BackgroundWorker

  def self.import_from_twitter
    Resque.enqueue(TwitterImporter)
  end

  def self.import_from_github
    Resque.enqueue(GithubImporter)
  end

  def self.import_from_instagram
    Resque.enqueue(InstagramImporter)
  end

  def self.import_from_pointsfeed
    Resque.enqueue(PointsfeedImporter)
  end

end