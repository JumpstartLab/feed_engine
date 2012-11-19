class FeedsImporter
  @queue = :medium

  def self.perform
    BackgroundWorker.import_from_twitter
    BackgroundWorker.import_from_github
    BackgroundWorker.import_from_instagram
    BackgroundWorker.import_from_pointsfeed

    Resque.enqueue_in(2.minutes, FeedsImporter)
  end
end