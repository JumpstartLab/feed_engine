require 'minitest_helper'

class UsersControllerTest < ActionController::TestCase
  test "show returns posts based on the subdomain" do
    user = Fabricate(:user)
    fabricate_post(user.feed)
    @request.host = "#{user.subdomain}.mysubdomain.local" 
    get :show
    assert_response :success
  end
  
  test "create returns success when creating a new user with valid creds" do
    password = "blachity1"
    post :create, :user => { :email => "blah@lsqa.net", :display_name => "blah", :password => password, :password_confirmation => password }, :format => :json
    
    assert_response :success
  end
  
  test "update password returns success when submitting valid creds" do
    current_password = "asdf1234"
    new_password = '1234asdf'
    user = Fabricate(:user, :password => "asdf1234")
    login_user(user)
    
    post :update, :user => { :current_password => current_password, :new_password => new_password, :password_confirmation => new_password }, :format => :json
    
    assert_response :success
  end
  
  test "update password returns unprocessable when submitting invalid creds" do
    current_password = "asdf1234"
    new_password = '1234asdf'
    user = Fabricate(:user, :password => "asdf1234")
    login_user(user)
    
    post :update, :user => { :current_password => current_password, :new_password => "1", :password_confirmation => new_password }, :format => :json
    
    assert_response :unprocessable_entity
  end
  
  test "reset password returns success and send user reset password email" do
    user = Fabricate(:user)
    post :reset_password, :email => user.email, :format => :json
    assert_response :success
  end
end