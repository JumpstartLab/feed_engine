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
  fill_in "Email", with: email
end

When /^I fill in display name with "(.*?)"$/ do |display_name|
  fill_in "Display name", with: display_name
end

When /^I fill in password and password confirmation with "(.*?)"$/ do |password|
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
end

When /^I submit the form$/ do
  within("form") do
    click_on "Sign up"
  end
end

Then /^I should see a confirmation message thanking me for signing up$/ do
  flash_text.should include "Welcome! You have signed up successfully."
end

Then /^I should be viewing the dashboard at '\/dashboard'$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should receive a welcome email at my address$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have signed up before with "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in email address with "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an error message that the email is taken$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should be viewing the signup form$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the data I have entered is still present$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have never signed up before$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an error message that the email is not of the right format$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an error message that email is required$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an error message that the display name must be only letters, numbers, dashes, or underscores$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an error message that the display name is required$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an error message that the password must be (\\d+) or more characters$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in password with "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in password confirmation with "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
