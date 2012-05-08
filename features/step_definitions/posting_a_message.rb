Given /^I am viewing the dashboard at "(.*?)"$/ do |path|
  visit(path)
end

Then /^I should see a form to create a text message$/ do
  should have_selector("form[name=text-message]")
end

When /^I click create$/ do
  click_on "Create"
end

Then /^I should see an error message requiring text contents$/ do
  flash_text.should include "There were errors saving your post!"
end

Then /^I should see the form to create a text message$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I fill in the message text with (\\d+) 'a's$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an error message requiring text to be less than or equal to (\\d+) characters$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the data I have entered is present$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I fill in the message text with "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a confirmation message that my message has been saved$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see my dashboard$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I fill in the message text with (\\d+) 'a's$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an error message requiring text to be less than or equal to (\\d+) characters$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
