Given /^I click the "image" tab$/ do
  click_on "Image"
end

Then /^I should see a form to create an image message$/ do
  should have_selector("form[name=image-post]")
end

When /^I click post image$/ do
  click_on "Post Image"
end

Then /^I should see an error message requiring a link to an image$/ do
  flash_text.should include "There were errors posting your image!"
end

Then /^I should see the form to create an image message$/ do
  should have_selector("form[name=image-post]")
end

When /^I fill in the image link field with a link of (\d+) characters$/ do |arg1|
  @url = ("a" * 2049)
  fill_in "External image url", with: @url
end

Then /^the image url I have entered is present$/ do
  find_field("External image url").value.should include @url
end

Then /^the image comment I have entered is present$/ do
  find('input[name="image_post[description]"]').value.should include @description
end

Then /^I should see an error message requiring the image link to be less than or equal to (\d+) characters$/ do |arg1|
  should have_content "too long (maximum is 2048 characters)"
end

Then /^I should see an error message requiring the link format to look like an http\/https link$/ do
  should have_content "must begin with http or https"
end

Then /^I should see an error message requiring the link format to end in an image extension \(car\-insensitive: jpg, jpeg, gif, bmp, png\)$/ do
  should have_content "must end in .jpeg, .jpg, .gif, .bmp, or .png"
end

When /^I fill in the image comment field with (\d+) 'a's$/ do |arg1|
  @description = ("a"*arg1.to_i)
  fill_in "image_post_description", with: @description
end

Then /^I should see an error message requiring the comment to be less than or equal to (\d+) characters$/ do |arg1|
  should have_content "is too long (maximum is 256 characters)"
end

When /^I fill in the comment field with "(.*?)"$/ do |arg1|
  @description = arg1
  fill_in "Description", with: @description
end

When /^I fill in the image link field with "(.*?)"$/ do |url|
  @url = url
  fill_in "External image url", with: url
end
