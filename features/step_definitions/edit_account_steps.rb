Given /^I am viewing the dashboard$/ do
  visit dashboard_url(:subdomain => false)
end

When /^I click the account tab$/ do
  find("#account").click
end

Then /^I should see a form to change my password$/ do
  should have_selector("#user_password")
end

When /^I fill in the password and password confirmation fields with matching strings (\d+) or more characters in length$/ do |update_password|
  @update_password = "hungry22"
  fill_in "Password", with: @update_password
  fill_in "Password confirmation", with: @update_password
  fill_in "Current password", with: "charles"
end

When /^I click to change password$/ do
  click_on "Update"
end

Then /^I am viewing my dashboard$/ do
  current_path.should == "/dashboard"
end

Then /^I see a confirmation message$/ do
  # flash_text.should include "Account updated!"
end

Then /^my password has changed$/ do
  click_on "Sign out"
  click_on "sign in"
  fill_in "Email", with: "foo@bar.com"
  fill_in "Password", with: "hungry22"
  click_on "Sign in"
  current_path.should == dashboard_path
end

When /^I fill in the password and password confirmation fields with non\-matching strings (\d+) or more characters in length$/ do |arg1|
  fill_in "Password", with: "hungry23"
  fill_in "Password confirmation", with: "hungry24"
  fill_in "Current password", with: "hungry22"
  click_on "Update"
end

Then /^I see an error message that the password and confirmation must match$/ do
  page.should have_content "Please review the problems below"
end

Then /^I see the edit account form$/ do
  current_path.should == user_index_path
end