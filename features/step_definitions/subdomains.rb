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
  should have_selector('#posts')
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

When /^I view hungryfeeder\.feedengine\.com$/ do
  visit root_url(subdomain: @user1.display_name)
end

Given /^there is a feed with messages at "(.*?)"$/ do |arg1|
  @user1 = User.create(:display_name => "charles", 
                      :email => "foo@bar.com",
                      :password => "charles",
                      :password_confirmation => "charles")
  @post1 = @user1.text_posts.create(body: "Example message 1")
  @post2 = @user1.text_posts.create(body: "Example message 2")
end

Then /^I should see the most recent messages$/ do
  should have_selector('#posts')
end

Given /^I am logged out$/ do
  visit root_url(subdomain: false)
  if page.has_selector?("#sign_out")
    click_on("Sign out")
  end
end