$:.unshift(File.expand_path("../", __FILE__))
require 'feeder/worker'

module Feeder
  MASTER_TOKEN   = "d85a867e21cc571242e10ef62bc07ef9"
end

Feeder::Worker.start
