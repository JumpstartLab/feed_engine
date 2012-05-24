require 'minitest_helper'

class Api::PostsControllerTest < ActionController::TestCase
  test "create returns success when creating a post while auth'ed with valid data" do
    user = Fabricate(:user)
    @request.env['HTTP_TOKEN'] = user.authentication_token
    post :create, :type => "Text", :content => "OHAI!!1!" , :format => :json
    
    assert_response :success
  end
  
  test "create returns errors when creating a post while auth'ed with invalid data" do
    user = Fabricate(:user)
    @request.env['HTTP_TOKEN'] = user.authentication_token
    post :create, :type => "Text", :content => "", :format => :json
    
    assert_response :not_acceptable
  end
  
  test "create returns errors when creating a post while unauth'ed" do
    post :create, :type => "Text", :content => "OHAI!!1!", :format => :json
    assert_response :unauthorized
  end
  
  test "index returns a collection of postables" do
    users = [Fabricate(:user), Fabricate(:user)]
    fabricate_post(users.first.feed)
    fabricate_post(users.last.feed)
    fabricate_post(users.last.feed)
    @request.env['HTTP_TOKEN'] = users.first.authentication_token
    
    get :index, :feed_name => users.last.feed.name, :format => :json
    
    assert_response :success
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
    @request.env['HTTP_TOKEN'] = users.first.authentication_token
    
    post :refeed, :post_id => users.last.feed.posts.last.id, :format => :json
    
    assert_response :created
    assert_equal users.first.feed.posts.last.postable, users.last.feed.posts.last.postable
  end
end