CarrierWave.configure do |config|
 config.fog_credentials = {
   :provider               => 'AWS',       # required
   :aws_access_key_id      => 'AKIAIQJ2DP4FGMQZLUQA',       # required
   :aws_secret_access_key  => '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', # required
   }
   config.fog_directory  = 'feed-engine'                     # required
   config.fog_public     = false                                   # optional, defaults to true
   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end