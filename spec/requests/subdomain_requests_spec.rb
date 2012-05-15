require 'spec_helper'

describe User do
  context "with a display name" do
    let(:user) { Fabricate(:user) }

    before(:all) do
      logout
    end

    after(:each) do
      reset_host
    end

    it "is redirected to root with a message if subdomain doesn't exist" do
      set_host('foo')
      visit root_path
      page.should have_content "User foo not found"
      current_path.should == root_path
    end

    context "who is logged in" do
      before(:each) do
        login_as(user)
      end

      it "is redirected to their feed from root with a subdomain" do
        set_host(user.display_name)
        visit root_path
        current_url.should include user.display_name
        page.should have_content "#{user.display_name}'s feed"
      end

      it "is redirected to their dashboard from the root without subdomain" do
        visit root_path
        current_path.should == dashboard_path
      end

      context "and has made posts" do
        before(:each) do
          3.times do
            Fabricate(:message, :poster_id => user.id)
            Fabricate(:image, :poster_id => user.id)
            Fabricate(:link, :poster_id => user.id)
          end
        end

        context "visits their feed" do
          before(:each) do
            set_host(user.display_name)
            visit root_path
          end

          it "and sees their posts" do
            current_url.should include user.display_name
            page.should have_content "#{user.display_name}'s feed"

            user.messages.each do |message|
              page.should have_content message.body
            end
            user.images.each do |image|
              page.should have_content image.description
            end
            user.links.each do |link|
              page.should have_content link.description
            end
          end
        end
      end
    end
  end
end
