Given /^I am viewing the root$/ do
  visit("/")
end

Given /^I am not logged in$/ do
  should have_selector("#sign_in")
end

Given /^I have never signed up$/ do
end

When /^I click the sign up link$/ do
  click_on "Sign up"
end

Then /^I should see the sign up form at "(.*?)"$/ do |path|
  should have_selector("#new_user")
end

When /^I fill in email address with  "(.*?)"$/ do |email|
  @email_address = email
  fill_in "Email", with: @email_address
end

When /^I fill in display name with "(.*?)"$/ do |display_name|
  @display_name = display_name
  fill_in "Display name", with: display_name
end

When /^I fill in password and password confirmation with "(.*?)"$/ do |password|
  @password = password
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
end

When /^I submit the form$/ do
  within("form") do
    click_on "Sign up"
  end
end

Then /^I should see a confirmation message thanking me for signing up$/ do
  page.should_have_content "Welcome! You have signed up successfully."
end

Then /^I should be viewing the dashboard at '\/dashboard'$/ do
  current_path.should == "/dashboard"
end

Then /^I should receive a welcome email at my address$/ do
  @email_address = ActionMailer::Base.deliveries.first
  @email_address.body.should include("Hope you are hungry")
end

Given /^I have signed up before with "(.*?)"$/ do |arg1|
  @user1 = User.create(:display_name => "charles", 
                      :email => "foo@bar.com",
                      :password => "charles",
                      :password_confirmation => "charles")
end

Given /^I am signed in$/ do
  visit new_user_session_path
  fill_in "Login", with: @user1.email
  fill_in "Password", with: "charles"
  within("form") do
    click_link_or_button "Sign in"
  end
end

When /^I fill in email address with "(.*?)"$/ do |foobarcom|
  fill_in "Email", with: foobarcom
end

Then /^I should see an error message that the email is taken$/ do
  find("form").text.should include "has already been taken"
end

Then /^I should be viewing the signup form$/ do
  should have_selector("#new_user")
end

Then /^the data I have entered is still present$/ do
  find_field("Display name").value.should include @display_name.to_s
end

Given /^I have never signed up before$/ do
end


Then /^I should see an error message that the email is not of the right format$/ do
  find("form").text.should include "is invalid"
end

Then /^I should see an error message that email is required$/ do
  find("form").text.should include "can't be blank"
end

Then /^I should see an error message that the display name must be only letters, numbers, dashes, or underscores$/ do
  find("form").text.should include "is invalid"
end

Then /^I should see an error message that the display name is required$/ do
  find("form").text.should include "can't be blank"
end

Then /^I should see an error message that the password cannot be blank$/ do
  find("form").text.should include "can't be blank"
end

When /^I fill in password with "(.*?)"$/ do |password1|
  fill_in "Password", with: password1
end

When /^I fill in password confirmation with "(.*?)"$/ do |password2|
  fill_in "Password", with: password2
end

Then /^I should see an error message that the passwords must match$/ do
  find("form").text.should include "doesn't match confirmation"
end

Then /^I skip the link accounts page$/ do
  click_on("skip this step")
  click_on("skip this step")
  click_on("Finish")
end
