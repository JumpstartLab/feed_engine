#
#
#   DEPRICATED DUE TO TRUSTING DEVISE
#
#
# require 'spec_helper'

# describe "User pages" do

#   context "when not logged in" do
#     before(:each) do
#       Capybara.app_host = "http://feed.test"
#       visit root_path
#     end
#     it "sends me to a signup form" do
#       page.should have_content("Sign up")
#     end

#     context "creating an account" do
#       before(:each) { visit signup_path }

#       it "sends you to /signup" do
#         current_path.should == '/signup'
#       end


#       # it "lets me create an account with new info" do
#       #   fill_in 'user_email', with: 'foo@bar.com'
#       #   fill_in 'user_display_name', with: 'displayname'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   within(".actions") do
#       #     click_link_or_button 'Sign up'
#       #   end
#       #   test_user = User.last
#       #   test_user.email.should == "foo@bar.com"
#       # end

#       # it "throws up a confirmation message on successful creation" do
#       #   fill_in 'user_display_name', with: 'displayname'
#       #   fill_in 'user_email', with: 'foo@bar.com'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   within(".actions") do
#       #     click_link_or_button 'Sign up'
#       #   end
#       #   page.should have_content('You have signed up successfully.')
#       # end

#       # it "sends a confirmation email" do
#       #   fill_in 'user_display_name', with: 'displayname'
#       #   fill_in 'user_email', with: 'foo@bar.com'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   within(".actions") do
#       #     click_link_or_button 'Sign up'
#       #   end
#       #   last_email = ActionMailer::Base.deliveries.last
#       #   last_email.subject.should == "Welcome to Hungrlr!"
#       # end

#       # it "sends you to a page asking you to connect with twitter" do
#       #   fill_in 'user_email', with: 'foomeh@bar.com'
#       #   fill_in 'user_display_name', with: 'displayname5'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   within(".actions") { click_link_or_button 'Sign up' }
#       #   current_path.should == new_authentication_path
#       # end

#       # # Unsuccessful Signup

#       # it "does not accept duplicate email addresses" do
#       #   fill_in 'user_display_name', with: 'displayname'
#       #   fill_in 'user_email', with: 'foo@bar.com'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   within(".actions") do
#       #     click_link_or_button 'Sign up'
#       #   end
#       #   click_link_or_button 'Sign out'

#       #   visit new_user_registration_path
#       #   fill_in 'user_display_name', with: 'displayname2'
#       #   fill_in 'user_email', with: 'foo@bar.com'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   within(".actions") do
#       #     click_link_or_button 'Sign up'
#       #   end
#       #   page.should have_content('has already been taken')
#       # end

#       # it "saves previously entered information when rejecting a duplicate email addresses" do
#       #   fill_in 'user_display_name', with: "mikeisawesome"
#       #   fill_in 'user_email', with: 'foo@bar.com'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   within(".actions") do
#       #     click_link_or_button 'Sign up'
#       #   end
#       #   click_link_or_button 'Sign out'

#       #   visit new_user_registration_path
#       #   fill_in 'user_email', with: 'foo@bar.com'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   within(".actions") do
#       #     click_link_or_button 'Sign up'
#       #   end
#       # end

#       # it "rejects a malformed display name" do
#       #   fill_in 'user_display_name', with: 'display name'
#       #   fill_in 'user_email', with: 'foo@bar.com'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   within(".actions") do
#       #     click_link_or_button 'Sign up'
#       #   end
#       #   page.should have_content('Display name must only be letters, numbers, or dashes')
#       # end

#       # it "keeps you on the signup for when submitted display name is bad" do
#       #   fill_in 'user_display_name', with: 'display name'
#       #   fill_in 'user_email', with: 'foo@bar.com'
#       #   fill_in 'user_password', with: 'hungry'
#       #   fill_in 'user_password_confirmation', with: 'hungry'
#       #   page.should have_content('Sign up')
#       # end
#       # Successful Signup

#       it "lets me create an account with new info" do
#         fill_in 'user_email', with: 'foo@bar.com'
#         fill_in 'user_display_name', with: 'displayname'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         within(".actions") do
#           click_link_or_button 'Sign up'
#         end
#         test_user = User.last
#         test_user.email.should == "foo@bar.com"
#       end

#       it "throws up a confirmation message on successful creation" do
#         fill_in 'user_display_name', with: 'displayname'
#         fill_in 'user_email', with: 'foo@bar.com'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         within(".actions") do
#           click_link_or_button 'Sign up'
#         end
#         page.should have_content('You have signed up successfully.')
#       end

#       it "sends a confirmation email" do
#         fill_in 'user_display_name', with: 'displayname'
#         fill_in 'user_email', with: 'foo@bar.com'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         within(".actions") do
#           click_link_or_button 'Sign up'
#         end
#         last_email = ActionMailer::Base.deliveries.last
#         last_email.subject.should == "Welcome to Hungrlr!"
#       end

#       it "sends you to a page asking you to connect with twitter" do
#         fill_in 'user_email', with: 'foomeh@bar.com'
#         fill_in 'user_display_name', with: 'displayname5'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         within(".actions") { click_link_or_button 'Sign up' }
#         current_path.should == new_authentication_path
#       end

#       # Unsuccessful Signup

#       it "does not accept duplicate email addresses" do
#         fill_in 'user_display_name', with: 'displayname'
#         fill_in 'user_email', with: 'foo@bar.com'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         within(".actions") do
#           click_link_or_button 'Sign up'
#         end
#         click_link_or_button 'Sign out'

#         visit new_user_registration_path
#         fill_in 'user_display_name', with: 'displayname2'
#         fill_in 'user_email', with: 'foo@bar.com'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         within(".actions") do
#           click_link_or_button 'Sign up'
#         end
#         page.should have_content('has already been taken')
#       end

#       it "saves previously entered information when rejecting a duplicate email addresses" do
#         fill_in 'user_display_name', with: "mikeisawesome"
#         fill_in 'user_email', with: 'foo@bar.com'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         within(".actions") do
#           click_link_or_button 'Sign up'
#         end
#         click_link_or_button 'Sign out'

#         visit new_user_registration_path
#         fill_in 'user_email', with: 'foo@bar.com'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         within(".actions") do
#           click_link_or_button 'Sign up'
#         end
#       end

#       it "rejects a malformed display name" do
#         fill_in 'user_display_name', with: 'display name'
#         fill_in 'user_email', with: 'foo@bar.com'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         within(".actions") do
#           click_link_or_button 'Sign up'
#         end
#         page.should have_content('Display name must only be letters, numbers, or dashes')
#       end

#       it "keeps you on the signup for when submitted display name is bad" do
#         fill_in 'user_display_name', with: 'display name'
#         fill_in 'user_email', with: 'foo@bar.com'
#         fill_in 'user_password', with: 'hungry'
#         fill_in 'user_password_confirmation', with: 'hungry'
#         page.should have_content('Sign up')
#       end
#     end
#   end

#   context "when logged in and viewing the dashboard" do
#     # We assume devise works...
#     # let!(:user) do
#     #   FactoryGirl.create(:user)
#     # end
#     # before(:each) do
#     #   login(user)
#     # end

#     # context "the account tab" do
#     #   let(:previous_password) { user.encrypted_password }
#     #   before(:each) do
#     #     click_link_or_button("Account")
#     #   end

#     #   it "provides a form to edit the password" do
#     #     page.should have_selector('form#edit_user')
#     #   end

#     #   it "changes the password when fields are correctly filled" do
#     #     fill_in 'user_password', with: 'hungry2'
#     #     fill_in 'user_password_confirmation', with: 'hungry2'
#     #     fill_in 'user_current_password', with: 'hungry'
#     #     click_link_or_button 'Update'
#     #     User.last.encrypted_password.should_not == previous_password
#     #   end

#     #   it "does not change the password when fields don't match" do
#     #     fill_in 'user_password', with: 'hungry2'
#     #     fill_in 'user_password_confirmation', with: 'foobar'
#     #     fill_in 'user_current_password', with: 'hungry'
#     #     click_link_or_button 'Update'
#     #     User.last.encrypted_password.should == previous_password
#     #   end

#     #   it "does not change the password when the current password is incorrect" do
#     #     fill_in 'user_password', with: 'hungry2'
#     #     fill_in 'user_password_confirmation', with: 'hungry2'
#     #     fill_in 'user_current_password', with: 'foobar'
#     #     click_link_or_button 'Update'
#     #     User.last.encrypted_password.should == previous_password
#     #   end

#     #   it "has a link to provide the user's api token which provides the token" do
#     #     page.should have_content("Show my Auth Token")
#     #     click_link_or_button("Show my Auth Token")
#     #     page.should have_content("#{user.authentication_token}")
#     #   end

#     # Switch for FactoryGirl user login once Mike's api branch is pulled in
#     let!(:user) do
#       FactoryGirl.create(:user)
#     end
#     before(:each) do
#       login(user)
#     end

#     context "the account tab" do
#       let(:previous_password) { user.encrypted_password }
#       before(:each) do
#         click_link_or_button("Account")
#       end

#       it "provides a form to edit the password" do
#         page.should have_selector('form#edit_user')
#       end

#       it "changes the password when fields are correctly filled" do
#         fill_in 'user_password', with: 'hungry2'
#         fill_in 'user_password_confirmation', with: 'hungry2'
#         fill_in 'user_current_password', with: 'hungry'
#         click_link_or_button 'Update'
#         User.last.encrypted_password.should_not == previous_password
#       end

#       it "does not change the password when fields don't match" do
#         fill_in 'user_password', with: 'hungry2'
#         fill_in 'user_password_confirmation', with: 'foobar'
#         fill_in 'user_current_password', with: 'hungry'
#         click_link_or_button 'Update'
#         User.last.encrypted_password.should == previous_password
#       end

#       it "does not change the password when the current password is incorrect" do
#         fill_in 'user_password', with: 'hungry2'
#         fill_in 'user_password_confirmation', with: 'hungry2'
#         fill_in 'user_current_password', with: 'foobar'
#         click_link_or_button 'Update'
#         User.last.encrypted_password.should == previous_password
#       end

#       it "has a link to provide the user's api token which provides the token" do
#         page.should have_content("Show my Auth Token")
#         click_link_or_button("Show my Auth Token")
#         page.should have_content("#{user.authentication_token}")
#       end
#     end
#   end

# end