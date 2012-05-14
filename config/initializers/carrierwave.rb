CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAIQ6A4WA26WTJAN2Q',
    :aws_secret_access_key  => '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',
  }
  config.fog_directory  = 'image-posts'
end