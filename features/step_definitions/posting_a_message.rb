Given /^I am viewing the dashboard at "(.*?)"$/ do |path|
  visit(path)
end

Then /^I should see a form to create a text message$/ do
  should have_selector("form[name=text-message]")
end

When /^I click post message$/ do
  click_on "Post Message"
end

Then /^I should see an error message requiring text contents$/ do
  flash_text.should include "There were errors saving your post!"
end

# XXX this looks eerily similar.
Then /^I should see the form to create a text message$/ do
  should have_selector("form[name=text-message]")
end

When /^I fill in the message text with 513 'a's$/ do
  @message = "a"*513
  fill_in("Body", with: @message)
end

Then /^I should see an error message requiring text to be less than or equal to 512 characters$/ do
  find("form[name=text-message]").text.should include "is too long (maximum is 512 characters)"
end

Then /^the data I have entered is present$/ do
  page.should have_content @message
end

When /^I fill in the message text with "(.*?)"$/ do |text|
  @message = text
  fill_in("Body", with: @message)
end

Then /^I should see a confirmation message that my message has been saved$/ do
  flash_text.should include "Your message was saved!"
end

Then /^I should see my dashboard$/ do
  current_path.should == "/dashboard"
end
