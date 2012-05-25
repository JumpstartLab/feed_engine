module VideoValidations
  def self.included(source)
    source.validates_presence_of :link,
                                 message: "You must provide a YouTube link"
    source.validates_length_of :link, maximum: 2048
    source.validates_format_of :link, :with => YOUTUBE_REGEX,
                                message: "Must be a YouTube link"
    source.validates_length_of :comment, :within => 3..256, :allow_blank => true
  end

end