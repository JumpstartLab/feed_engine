require 'minitest_helper'

describe Link do
  it "creates a new Link record on create" do
    link = Link.create(:user_id => 1, 
      :content => "http://www.google.com",
      :comment => "Testing 123")
    assert_equal link.valid?, true
    assert_equal link.user_id, 1
    assert_equal link.content, "http://www.google.com"
    assert_equal link.comment, "Testing 123"
  end
  
  it "does not require a comment to create an link" do
    link = Link.create(:user_id => 1, 
      :content => "http://www.google.com")
    assert_equal link.valid?, true
  end

  it "rejects Link records without an link url" do
    link = Link.create(:user_id => 1,
      :comment => "Testing 123")
    assert_equal link.valid?, false
  end
  
  it "rejects link urls longer than 2048 characters" do
    link = Link.create(:user_id => 1, 
      :content => "http://www.#{'a'*2034}.com")
    assert_equal link.valid?, false
  end
    
  it "rejects link urls that do not begin with http|https" do
    link = Link.create(:user_id => 1, 
      :content => "www.google.com")
    assert_equal link.valid?, false
  end

  it "accepts link urls that begin with http" do
    link = Link.create(:user_id => 1, 
      :content => "http://www.google.com")
    assert_equal link.valid?, true
  end

  it "accepts link urls that begin with http" do
    link = Link.create(:user_id => 1, 
      :content => "https://www.google.com")
    assert_equal link.valid?, true
  end

  it "rejects comments longer than 256 characters" do
    link = Link.create(:user_id => 1, 
      :content => "https://www.google.com",
      :comment => "a"*257)
    assert_equal link.valid?, false
  end
end
