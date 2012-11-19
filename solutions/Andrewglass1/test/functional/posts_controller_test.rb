require 'minitest_helper'

class PostsControllerTest < ActionController::TestCase
  test "create returns success when creating a post while auth'ed with valid data" do
    user = Fabricate(:user)
    login_user(user)
    
    post :create, :type => "Text", :text => { :content => "OHAI!!1!" }, :format => :json
    
    assert_response :success
  end
  
  test "create returns errors when creating a post while auth'ed with invalid data" do
    user = Fabricate(:user)
    login_user(user)
    
    post :create, :type => "Text", :text => { :content => "" }, :format => :json
    
    assert_response :unprocessable_entity
  end
  
  test "create returns errors when creating a post while unauth'ed" do
    post :create, :type => "Text", :text => { :content => "OHAI!!1!" }, :format => :json
    assert_response :unauthorized
  end
  
  test "index returns a collection of postables" do
    users = [Fabricate(:user), Fabricate(:user)]
    users.each do |user|
      FEED_TYPES.each do |type|
        post = user.feed.posts.create
        post.postable = Fabricate("#{type.to_s.downcase}_post".to_sym)
        post.save
      end
    end
    
    get :index, :format => :json
    
    assert_response :success
    returned_posts = JSON.parse(@response.body)["posts"]
    assert_equal (FEED_TYPES.count * users.count), returned_posts.count
  end
  
  test "show returns all of the posts for a given user" do
    users = [Fabricate(:user), Fabricate(:user)]
    users.each do |user|
      FEED_TYPES.each do |type|
        post = user.feed.posts.create
        post.postable = Fabricate("#{type.to_s.downcase}_post".to_sym)
        post.save
      end
    end
    
    get :show, :id => users.first.display_name, :format => :json
    
    assert_response :success
    returned_posts = JSON.parse(@response.body)["posts"]
    assert_equal FEED_TYPES.count, returned_posts.count
  end
  
  test "ind returns all of the posts for the current user when logged in" do
    users = [Fabricate(:user), Fabricate(:user)]
    users.each_with_index do |user, index|
      (index + 1).times do
        post = user.feed.posts.create
        post.postable = Fabricate(:text_post)
        post.save
      end
    end
    login_user(users.last)
    
    get :ind, :format => :json
    
    returned_posts = JSON.parse(@response.body)["posts"]
    assert_equal 2, returned_posts.count
  end
  
  test "refeed clones a given post to the current user's feed" do
    users = [Fabricate(:user), Fabricate(:user)]
    users.each do |user|
      post = user.feed.posts.create
      post.postable = Fabricate(:text_post)
      post.save
    end
    login_user(users.first)
    
    post :refeed, :id => users.last.feed.posts.last.id, :format => :json
    
    assert_response :created
    assert_equal users.first.feed.posts.last.postable, users.last.feed.posts.last.postable
  end
end