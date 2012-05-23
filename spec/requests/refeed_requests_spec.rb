require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user_with_posts) }
  let(:other_user) { Fabricate(:user_with_posts) }

  context "who is not authenticated" do
    before(:all) do
      logout
    end

    it "does not see refeed links" do
      visit root_path
      page.should_not have_link "Refeed"
    end
  end

  context "who is authenticated" do
    before(:each) do
      reset_host
      login_as(user)
      visit root_path
    end

    after(:each) do
      reset_host
    end

    it "sees refeed links for other user's items" do
      set_host(other_user.display_name)
      visit root_path
      find(".#{other_user.display_name}_post").should have_link "Refeed"
    end

    it "does not see refeed links for their own items" do
      find(".#{user.display_name}_post").should_not have_link "Refeed"
    end

    it "does not see refeed links for items they've already refed" do
      message = Message.find_by_poster_id(other_user.id)
      set_host(other_user.display_name)
      visit root_path
      find("#refeed_item_#{message.item.id}").click
      page.should_not have_link "refeed_item_#{message.item.id}"
    end

    it "clicks refeed and sees the refed item in their feed" do
      message = Message.find_by_poster_id(other_user.id)
      set_host(other_user.display_name)
      visit root_path
      find("#refeed_item_#{message.item.id}").click
      set_host(user.display_name)
      visit root_path
      page.should have_content message.body
    end
    context "refeeds another feed from another user's feed" do
      let!(:other_user) { Fabricate(:user) }
      before(:each) do
        set_host other_user.subdomain
        visit root_path
      end
      it "shows a link to refeed" do
        page.should have_link "Refeed"
      end
      it "creates a subscription for the other user's feed" do
        expect { click_link_or_button "Refeed" }.to change { user.subscriptions.count }.by(1)
        user.subscriptions.last.provider.should == "refeed"
        user.subscriptions.last.uid.should == other_user.id.to_s
      end
      context "and a refeed subscription has already been created" do
        let!(:refeed_subscription) { Fabricate(:subscription,
                                               :provider => "refeed",
                                               :user_id => user.id,
                                               :uid => other_user.id
                                              )
        }
        it "does not show a link to refeed" do
          set_host other_user.subdomain
          visit root_path
          page.should_not have_link "Refeed"
        end
      end
      context "and an item has been refeeded" do
        let!(:body_post) {
          random_body_type = ["message", "tweet", "instapound"].sample
          Fabricate(random_body_type.to_sym, :poster_id => other_user.id)
        }
        let!(:description_post) {
          random_description_type = ["image", "link"].sample
          Fabricate(random_description_type.to_sym, :poster_id => other_user.id)
        }
        let!(:refeeded_body_item) { Refeed.create(poster_id: user.id,
                                                  original_poster_id: other_user.id,
                                                  post_id: body_post.id,
                                                  post_type: body_post.type
                                                 )
        }
        let!(:refeeded_description_item) { Refeed.create(poster_id: user.id,
                                                         original_poster_id: other_user.id,
                                                         post_id: description_post.id,
                                                         post_type: description_post.type
                                                        )
        }
        before(:each) do
          set_host(user.subdomain)
          visit root_path
        end

        it "shows the item on the user's feed" do
          within "#item_#{refeeded_body_item.item.id}" do
            page.should have_content body_post.body
          end
          within "#item_#{refeeded_description_item.item.id}" do
            page.should have_content description_post.description
          end
        end
        it "shows the display name of both the original poster and the refeeder on the item" do
          [refeeded_body_item, refeeded_description_item].each do |refeeded_post|
            [User.find(refeeded_post.poster_id), User.find(refeeded_post.original_poster_id)].each do |person|
              within "#item_#{refeeded_post.item.id}" do
                page.should have_content person.display_name
              end
            end
          end
        end
      end
    end
  end
end
