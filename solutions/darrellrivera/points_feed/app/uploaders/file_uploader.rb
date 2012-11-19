# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  storage :fog
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.original_post_id}"
  end
end
