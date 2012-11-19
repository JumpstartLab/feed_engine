require 'spec_helper'

describe "Authentications" do
  it "signs up a user and skips authentications" do
    visit "/signup"
    fill_in "user_email", :with => Faker::Internet.email
    fill_in "user_display_name", :with => "testuser_1"
    fill_in "user_password", :with => "foobar" 
    fill_in "user_password_confirmation", :with => "foobar" 
    click_on "Sign up"
    page.should have_content "Welcome! You have signed up successfully." 
    click_on "Skip"
    page.should have_content "You can link your"
    click_on "Skip"
    page.should have_content "You can link your"
    click_on "Skip"
    page.should have_content "Dashboard"
  end

  context "password changes" do
    let!(:user) { FactoryGirl.create(:user) }

    it "allows a user to change their password" do
      login(user)
      visit dashboard_path
      fill_in "user_current_password", with: "password"
      fill_in "user_password", with: "foobarfoobar"
      fill_in "user_password_confirmation", with: "foobarfoobar"
      click_on "Update"
      page.should have_content "You updated your account"
    end

    it "prevents against password mismatches" do
      login(user)
      visit dashboard_path
      fill_in "user_current_password", with: "password"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "foobar"
      click_on "Update"
      page.should have_content "doesn't match confirmation"
    end
  end
end