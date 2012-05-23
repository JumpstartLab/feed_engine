require 'minitest_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  test "returns success on create with valid data while auth'ed" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    login_user(user1)
    assert_difference('Subscription.count') do
      post :create, :feed_name => user2.feed.name
    end
    assert_response :success
  end
  
  test "returns failure on create with valid data while not auth'ed" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    session[:user] = nil
    assert_no_difference('Subscription.count') do
      post :create, :feed_id => user2.feed.id
    end
    assert_response :not_acceptable
  end
  
  test "returns failure on create with invalid data while auth'ed" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    login_user(user1)
    assert_no_difference('Subscription.count') do
      post :create
    end
    assert_response :not_acceptable
  end
end