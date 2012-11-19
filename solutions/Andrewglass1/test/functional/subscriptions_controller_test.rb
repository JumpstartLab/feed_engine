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
  
  test "index returns all subscriptions for the current user" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    user1.subscribe(user2.feed.name)
    login_user(user1)
    
    get :index, :format => :json
    
    assert_response :success
    returned_subs = JSON.parse(@response.body)["subscriptions"]
    assert_equal 1, returned_subs.count
    assert_equal user2.feed.name, returned_subs.first["feed_name"]
  end
  
  test "index returns emptiness if the current user has no subscriptions" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    login_user(user1)
    
    get :index, :format => :json
    
    assert_response :success
    returned_subs = JSON.parse(@response.body)["subscriptions"]
    assert_equal 0, returned_subs.count
    assert_equal [], returned_subs
  end
  
  test "index returns nothing when unauth'ed" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    user1.subscribe(user2.feed.name)
    
    get :index, :format => :json
    
    assert_response :unauthorized
  end
  
  test "destroy returns success after deleting the current user's subscription" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    user1.subscribe(user2.feed.name)
    login_user(user1)

    delete(:destroy, {'id' => user1.subscriptions.first, 'feed_id' => user1.subscriptions.first.feed_id, :format => :json })
    
    assert_response :success
  end

  test "destroy returns failure when unauth'ed" do
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    user1.subscribe(user2.feed.name)

    delete(:destroy, {'id' => user1.subscriptions.first, 'feed_id' => user1.subscriptions.first.feed_id, :format => :json })
    
    assert_response :unauthorized
  end

end