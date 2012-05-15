class TwitterImporter
  @queue = :medium

  def self.perform
    puts "This is me, pretending to import all the twitters"
  end
end