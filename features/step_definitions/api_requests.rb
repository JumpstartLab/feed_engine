When /^I request "(.*?)";$/ do |arg1|
  visit "#{arg1}"
end

Then /^I should receive a JSON array of feed items$/ do
  should have_content '"body":"Example message 1"'
end