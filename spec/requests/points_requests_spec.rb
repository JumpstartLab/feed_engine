require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user_with_posts) }
  let(:other_user) { Fabricate(:user_with_posts) }

  context "who is not authenticated" do
    before(:all) do
      logout
    end

    context "trying to give points" do
      let!(:user) { Fabricate(:user) }
      let!(:random_post_type) { ["message", "link", "github_event", "tweet", "image"].sample }
      let!(:random_post) { Fabricate(random_post_type.to_sym, poster_id: user.id) }
      it "is asked to sign up or sign in" do
        set_host(user.subdomain)
        visit root_path
        page.should have_content "Points!"
        click_link_or_button "Points! (#{random_post.points})"
        current_path.should == login_path(:subdomain => false)
        within "#main-content" do
          page.should have_content "Email"
          page.should have_content "Sign Up"
          page.should have_content "Log In"
          page.should have_content "must be logged in"
        end
      end
      context "after signing up" do
        it "increases the point count of that post" do
          set_host(user.subdomain)
          visit root_path
          click_link_or_button "Points! (#{random_post.points})"
          within "#signup" do
            fill_signup_form_as(new_user)
            click_link_or_button "Sign Up"
          end
          updated_post = random_post.class.find(random_post.id)
          updated_post.points.should == 1
        end
      end
      context "after logging in" do
        let!(:other_user) { Fabricate(:user) }
        before(:each) do
          set_host(user.subdomain)
          visit root_path
          click_link_or_button "Points! (#{random_post.points})"
        end
        it "increases the point count of that post" do
          within "#login" do
            fill_login_form_as(other_user)
            click_link_or_button "Log In"
          end
          updated_post = random_post.class.find(random_post.id)
          updated_post.points.should == 1
        end
        context "the user that signs in is the author of the post" do
          it "does not increase the point count of that post" do
            within "#login" do
              fill_login_form_as(user)
              click_link_or_button "Log In"
            end
            updated_post = random_post.class.find(random_post.id)
            updated_post.points.should == 0
          end
        end
      end
      context "and chooses not to log in or sign up" do
        it "does not increase the point count of that post" do
          set_host(user.subdomain)
          visit root_path
          click_link_or_button "Points! (#{random_post.points})"
          click_link_or_button "No thanks, take me back"
          current_path.should == root_path
          updated_post = random_post.class.find(random_post.id)
          updated_post.points.should == 0
        end
      end
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

    context "adds points" do
      let!(:other_user) { Fabricate(:user) }
      let(:random_post_type) { ["message", "link", "github_event", "tweet", "image"].sample }
      context "from the user show page" do
        context "on a different user's post" do
          let!(:random_post) { Fabricate(random_post_type.to_sym, poster_id: other_user.id) }
          it "add points to a post" do
            set_host(other_user.subdomain)
            visit root_path
            page.should have_content "Points!"
            click_link_or_button "Points! (#{random_post.points})"
            updated_post = random_post.class.find(random_post.id)
            updated_post.points.should == 1
            current_path.should == root_path
            within "#points" do
              page.should have_content updated_post.points
            end
          end
        end
        context "on their own post" do
          let!(:random_post) { Fabricate(random_post_type.to_sym, poster_id: user.id) }
          it "cannot give it's own post points" do
            set_host(user.subdomain)
            visit root_path
            page.should have_content "Points!"
            page.should_not have_link "Points! (#{random_post.points})"
          end
        end
      end
      context "from the root page" do
        context "on a different user's post" do
          let!(:random_post) { Fabricate(random_post_type.to_sym, poster_id: other_user.id) }
          it "add points to a post" do
            visit root_path
            page.should have_content "Points!"
            click_link_or_button "Points! (#{random_post.points})"
            updated_post = random_post.class.find(random_post.id)
            updated_post.points.should == 1
            current_path.should == root_path
            within "#points" do
              page.should have_content updated_post.points
            end
          end
        end
        context "on their own post" do
          let!(:random_post) { Fabricate(random_post_type.to_sym, poster_id: user.id) }
          it "cannot give it's own post points" do
            random_post = Fabricate(random_post_type.to_sym, poster_id: user.id)
            visit root_path
            page.should have_content "Points!"
            page.should_not have_link "Points! (#{random_post.points})"
          end
        end
      end
    end
  end
end

