require 'spec_helper'

describe "root" do
  let!(:user) { Fabricate(:user) }
  let!(:message1) { Fabricate(:message, poster_id: user.id) }
  let!(:link) { Fabricate(:link, poster_id: user.id) }
  let!(:image) { Fabricate(:image, poster_id: user.id) }

  context "when visiting root" do  
    it "sees content of message" do
      visit root_path
      page.should have_content message1.body
    end
    it "sees url of link" do
      visit root_path
      page.should have_content link.url
    end
    it "sees description of image" do
      visit root_path
      page.should have_content image.description
    end
  end
end