require 'minitest_helper'

describe Image do
  it "creates a new Image record on create" do
    image = Image.create(:user_id => 1, 
      :content => "http://www.google.com/image.jpg",
      :comment => "Testing 123")
    assert_equal image.valid?, true
    assert_equal image.user_id, 1
    assert_equal image.content, "http://www.google.com/image.jpg"
    assert_equal image.comment, "Testing 123"
  end
  
  it "does not require a comment to create an image" do
    image = Image.create(:user_id => 1, 
      :content => "http://www.google.com/image.jpg")
    assert_equal image.valid?, true
  end

  it "rejects Image records without an image url" do
    image = Image.create(:user_id => 1,
      :comment => "Testing 123")
    assert_equal image.valid?, false
  end
  
  it "rejects image urls longer than 2048 characters" do
    image = Image.create(:user_id => 1, 
      :content => "http://www.#{'a'*2024}.com/image.jpg")
    assert_equal image.valid?, false
  end

  it "rejects image urls that do not end in png|jpg|gif|jpeg" do
    image = Image.create(:user_id => 1, 
      :content => "http://www.google.com/image.jp")
    assert_equal image.valid?, false
  end
  
  it "accepts image urls that end in png" do
    image = Image.create(:user_id => 1, 
      :content => "http://www.google.com/image.png")
    assert_equal image.valid?, true
  end
  
  it "accepts image urls that end in jpg" do
    image = Image.create(:user_id => 1, 
      :content => "http://www.google.com/image.jpg")
    assert_equal image.valid?, true
  end
  
  it "accepts image urls that end in gif" do
    image = Image.create(:user_id => 1, 
      :content => "http://www.google.com/image.gif")
    assert_equal image.valid?, true
  end
  
  it "accepts image urls that end in jpeg" do
    image = Image.create(:user_id => 1, 
      :content => "http://www.google.com/image.jpeg")
    assert_equal image.valid?, true
  end
  
  it "rejects image urls that do not begin with http|https" do
    image = Image.create(:user_id => 1, 
      :content => "www.google.com/image.jpg")
    assert_equal image.valid?, false
  end

  it "accepts image urls that begin with http" do
    image = Image.create(:user_id => 1, 
      :content => "http://www.google.com/image.jpg")
    assert_equal image.valid?, true
  end

  it "accepts image urls that begin with http" do
    image = Image.create(:user_id => 1, 
      :content => "https://www.google.com/image.jpg")
    assert_equal image.valid?, true
  end

  it "rejects comments longer than 256 characters" do
    image = Image.create(:user_id => 1, 
      :content => "https://www.google.com/image.jpg",
      :comment => "a"*257)
    assert_equal image.valid?, false
  end
end
