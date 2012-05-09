Given /^I click the "(.*?)" tab$/ do |path|
  click_link_or_button "image"
end

Then /^I should see a form to create an image message$/ do
  should have_selector("form[name=image-post]")
end

When /^I click post$/ do
  click_on "Post"
end

Then /^I should see an error message requiring a link to an image$/ do
  flash_text.should include "There were errors posting your image!"
end

Then /^I should see the form to create an image message$/ do
  should have_selector("form[name=image-post]")
end

When /^I fill in the image link field with a link of (\d+) characters$/ do |arg1|
  fill_in :url, with: ("b" * 2049)
end

Then /^I should see an error message requiring the image link to be less than or equal to (\d+) characters$/ do |arg1|
  should have_content "too long (maximum is 2048 characters)"
end

When /^I fill in the link field with "(.*?)"$/ do |url|
  fill_in :url, with: url
end

Then /^I should see an error message requiring the link format to look like an http\/https link$/ do
  should have_content "must begin with http or https"
end

Then /^I should see an error message requiring the link format to end in an image extension \(car\-insensitive: jpg, jpeg, gif, bmp, png\)$/ do
  should have_content "must end in .jpeg, .jpg, .gif, .bmp, or .png"
end

When /^I fill in the comment field with (\d+) 'a's$/ do |arg1|
  fill_in "Description", with: ("a"*arg1.to_i)
end

Then /^I should see an error message requiring the comment to be less than or equal to (\d+) characters$/ do |arg1|
  should have_content "is too long (maximum is 256 characters)"
end

When /^I fill in the comment field with "(.*?)"$/ do |arg1|
  fill_in :description, with: arg1
end
