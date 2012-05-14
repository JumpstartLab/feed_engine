Given /^my display name is "(.*?)"$/ do |arg1|
  @user1.update_attributes(display_name: arg1)
end

Given /^I have created messages$/ do
  @post1 = @user1.text_posts.create(body: "Example message 1")
  @post2 = @user1.text_posts.create(body: "Example message 2")
end

When /^I view my subdomain site$/ do
  visit root_url(subdomain: @user1.display_name)
end

Then /^I should see my most recent messages$/ do
  should have_content @post1.body
  should have_content @post2.body
end

When /^I view feedengine\.com$/ do
  visit root_url(subdomain: false)
end

Then /^I am redirected to my dashboard at "(.*?)"$/ do |arg1|
  current_path.should == "/dashboard"
end

Then /^I see a prominent link to sign up for an account$/ do
  should have_content "Sign up"
end

Then /^I see a log in form$/ do
  should have_content "sign in"
end

When /^I log out$/ do
  click_on "Sign out"
end