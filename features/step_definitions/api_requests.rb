When /^I request "(.*?)";$/ do |arg1|
  visit "#{arg1}"
end

Then /^I should see an error for "(.*?)"$/ do |arg1|
  should have_content "#{arg1}"
end