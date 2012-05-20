require 'spec_helper.rb'
describe Growl do
  describe "#new" do
    let!(:user) { FactoryGirl.create(:user_with_growls) }
    it "defaults original created date to the current date" do
      user.growls.each do |growl|
        growl.original_created_at.should_not be_nil
      end
    end
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

