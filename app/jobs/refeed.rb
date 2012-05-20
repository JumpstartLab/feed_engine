require './app/lib/refeed_processor'

class Refeed
  @queue = :refeed

  def self.perform
    refeed_processor = Hungrlr::RefeedProcessor.new
    refeed_processor.run
  end
end
