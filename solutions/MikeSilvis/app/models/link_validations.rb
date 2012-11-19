module LinkValidations
  def self.included(source)
    source.validates_presence_of :link, message: "You must provide a link."
    source.validates_length_of :link, :maximum => 2048
    source.validates_format_of :link, :with => LINK_VALIDATOR_REGEX
    source.validates_length_of :comment, :within => 3..256, :allow_blank => true
    source.after_validation :send_photo_to_amazon
  end

end