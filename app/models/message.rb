class Message < Growl
  validates_presence_of :comment, message: "You must provide a message."
  validates_length_of :comment, :maximum => 512

  before_save :send_to_services

  def icon
    "glyphicons/glyphicons_010_envelope.png"
  end

  def parse_for_services
    services = comment.scan(/\B#(\S+)/).uniq
    services.collect { |service| service.first.downcase }
  end

  def send_to_services
    services = parse_for_services
    services.each do |service|
      case service
        when 'twitter' then send_twitter_update
      end
    end
  end

  # def send_twitter_update
  #   return if comment.length > 180
  #   client = user.twitter_client
  #   client.update(comment) if client
  # end
end
# == Schema Information
#
# Table name: growls
#
#  id                  :integer         not null, primary key
#  type                :string(255)
#  comment             :text
#  link                :text
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  user_id             :integer
#  photo_file_name     :string(255)
#  photo_content_type  :string(255)
#  photo_file_size     :integer
#  photo_updated_at    :datetime
#  regrowled_from_id   :integer
#  original_created_at :datetime
#  event_type          :string(255)
#

