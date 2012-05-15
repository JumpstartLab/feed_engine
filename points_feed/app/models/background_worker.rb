 class BackgroundWorker

  def self.import_from_twitter
    Resque.enqueue(TwitterImporter)
  end

end