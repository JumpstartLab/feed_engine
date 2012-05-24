CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['aws_access_key_id'],       # required
    :aws_secret_access_key  => ENV['aws_secret_access_key']      # required
    # :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'pointsfeedin'                     # required
  # config.fog_host       = 'https://s3.amazonaws.com'            # optional, defaults to nil
  config.fog_public     = true                                   # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end