module HasUploadedFile
  def self.included(source)
  source.has_attached_file :photo,
                    :storage => :s3,
                    :s3_credentials => S3Config::Credentials,
                    :styles => {
                                  :medium => "300x300>",
                                  :thumb => "100x100>"
                               }
  end
end