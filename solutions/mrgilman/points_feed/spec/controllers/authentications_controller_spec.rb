require File.dirname(__FILE__) + '/../spec_helper'
include Devise::TestHelpers

describe AuthenticationsController do
  fixtures :all
  render_views

  before(:each) do
    @user = Fabricate(:user)
    sign_in(@user)
  end

  let(:authentications) { mock('Authentications',:find_or_create_by_provider_and_uid => "something") }

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "create action should render new template when model is invalid" do

    Authentication.any_instance.stubs(:valid?).returns(false)
    visit("/auth/twitter")
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid", js: true do
    pending "This works in app but requires manual Q/A, automated tests fail."
    visit new_user_session_path
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: "hungry"
    click_button "Sign in"
    Authentication.any_instance.stubs(:valid?).returns(true)
    visit("/auth/twitter")
    page.should have_content("Twitter account linked")
  end

  it "destroy action should destroy model and redirect to index action" do
    authentication = Authentication.first
    delete :destroy, :id => authentication
    response.should redirect_to(dashboard_path)
    Authentication.exists?(authentication.id).should be_false
  end
end
