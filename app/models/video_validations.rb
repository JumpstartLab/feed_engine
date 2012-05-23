module VideoValidations
  def self.included(source)
    source.validates_presence_of :link, message: "You must provide a YouTube link"
    source.validates_length_of :link, maximum: 2048
    # Validate that it's a YouTube styled link
  end
end