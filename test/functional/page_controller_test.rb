require 'minitest_helper'

class PagesControllerTest < ActionController::TestCase
  test "index returns all users" do
    user = Fabricate(:user)
    
    get :index
    assert_response :success
  end

  test "footer returns success" do
    get :footer
    assert_response :success
  end
  
  # test "signin returns success" do
  #   get :signin
  #   assert_response :success
  # end
  # 
  # test "signup returns success" do
  #   get :signup
  #   assert_response :success
  # end

  # test "home returns all posts if there are existing users" do
  #   user = Fabricate(:user)
  #   fabricate_post(user.feed)
  #   
  #   get :home
  #   assert_response :success
  # end
  # 
  # test "home returns 404 if there are no existing users" do
  #   get :home
  #   assert_response :not_found
  # end

  # test "friends returns success" do
  #   get :friends
  #   assert_response :success
  # end
  # 
  # test "dashboard returns success" do
  #   get :dashboard
  #   assert_response :success
  # end
end