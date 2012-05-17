# require 'active_record_spec_helper'
# class Growl; end
# module LinkValidations; end
# require 'link'

describe Link do
  describe "#new" do
    let(:link) { Link.new(comment: "I love this site!", link: "http://www.hungryacademy.com") }
    before(:each) { link.stub(:send_photo_to_amazon).and_return(true) }

  end
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

