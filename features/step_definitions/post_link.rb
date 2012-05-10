Then /^I should see a form to create a link message$/ do
  should have_selector("form[name=link-post]")
end

Then /^I should see an error message requiring a link$/ do
  should have_content "can't be blank"
end

Then /^I should see the form to create a link message$/ do
  should have_selector("form[name=link-post]")
end

When /^I fill in the link field with a link of (\d+) characters$/ do |arg1|
  @url = "http://" + ("a" * 2049)
  fill_in "Url", with: @url
end

Then /^I should see an error message requiring the link to be less than or equal to (\d+) characters$/ do |arg1|
  should have_content "is too long (maximum is 2048 characters)"
end

When /^I fill in the link field with "(.*?)";$/ do |url|
  @url = url
  fill_in "Url", with: @url
end

Then /^the link url I have entered is present$/ do
  find('input[name="link_post[url]"]').value.should include @url
end

Then /^the link comment I have entered is present$/ do
  find('input[name="link_post[description]"]').value.should include @description
end

Given /^I click the "link" tab$/ do
  click_on "link"
end

When /^I fill in the link field with "(.*?)"$/ do |url|
  @url = url
  fill_in " Url", with: @url
end
