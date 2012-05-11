require "spec_helper"
describe Growl do
  describe ".for_user(display_name)" do
    before(:each) { x.any_instance.stub(:send_photo_to_amazon).and_return(true) }
    pending "Unit tests need written."
  end
end
# == Schema Information
#
# Table name: growls
#
#  id                 :integer         not null, primary key
#  type               :string(255)
#  comment            :text
#  link               :text
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  user_id            :integer
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

