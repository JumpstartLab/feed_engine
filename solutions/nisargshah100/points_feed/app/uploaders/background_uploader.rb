# encoding: utf-8

class BackgroundUploader < CarrierWave::Uploader::Base
  storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
