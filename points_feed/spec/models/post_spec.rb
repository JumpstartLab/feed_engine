require 'spec_helper'


describe TextPost do
  context "when creating" do
   it "allows the creation of a valid TextPost" do
      textpost = TextPost.new
      textpost.title = "Sample Title"
      textpost.content = "Sample Content"
      textpost.user_id = 1
      expect { textpost.save! }.should_not raise_error
      TextPost.count.should == 1
      TextPost.last.title.should == "Sample Title"
    end
  end

  it "disallows a TextPost with no user id" do
    textpost = TextPost.new  
    textpost.title = "Sample Title"
    textpost.content = "Sample Content"
    expect { textpost.save! }.should raise_error
    TextPost.count.should == 0
  end

  it "disallows a TextPost with no content" do
    textpost = TextPost.new  
    textpost.title = "Sample Title"
    textpost.user_id = 1
    expect { textpost.save! }.should raise_error
    TextPost.count.should == 0
  end

  it "disallows a TextPost with content over 512 characters" do
    textpost = TextPost.new
    textpost.title = "Sample Title"
    textpost.content = "a" * 513
    textpost.user_id = 1
    expect { textpost.save! }.should raise_error
    TextPost.count.should == 0
  end
end

describe LinkPost do
  context "when creating" do
    it "allows the creation of a valid LinkPost" do
      linkpost = LinkPost.new
      linkpost.title = "Sample Title"
      linkpost.content = "http://www.sample-link.com"
      linkpost.user_id = 1
      expect { linkpost.save! }.should_not raise_error
      LinkPost.count.should == 1
      LinkPost.last.title.should == "Sample Title"
    end
  end

  it "disallows a LinkPost with no user id" do
    linkpost = LinkPost.new  
    linkpost.title = "Sample Title"
    linkpost.content = "Sample Content"
    expect { linkpost.save! }.should raise_error
    LinkPost.count.should == 0
  end

  it "disallows a LinkPost with no content" do
    linkpost = LinkPost.new  
    linkpost.title = "Sample Title"
    linkpost.user_id = 1
    expect { linkpost.save! }.should raise_error
    LinkPost.count.should == 0
  end

  it "disallows a LinkPost with malformed URL" do
    linkpost = LinkPost.new  
    linkpost.title = "Sample Title"
    linkpost.content = "Bad URL"
    linkpost.user_id = 1
    expect { linkpost.save! }.should raise_error
    LinkPost.count.should == 0
  end

  it "allows a LinkPost with content over 512 characters" do
    linkpost = LinkPost.new
    linkpost.title = "Sample Title"
    linkpost.content = "http://" + ("a" * 513) + ".com"
    linkpost.user_id = 1
    expect { linkpost.save! }.should_not raise_error
    LinkPost.count.should == 1
  end

  it "disallows a LinkPost with content over 2048 characters" do
    linkpost = LinkPost.new
    linkpost.title = "Sample Title"
    linkpost.content = "http://" + ("a" * 2038) + ".com"
    linkpost.user_id = 1
    expect { linkpost.save! }.should raise_error
    LinkPost.count.should == 0
  end
end

describe ImagePost do
  context "when creating" do
    it "allows the creation of a valid ImagePost" do
      imagepost = ImagePost.new
      imagepost.title = "Sample Title"
      imagepost.content = "http://www.sample-link.com/example.png"
      imagepost.user_id = 1
      expect { imagepost.save! }.should_not raise_error
      ImagePost.count.should == 1
      ImagePost.last.title.should == "Sample Title"
    end
  end

  it "disallows a ImagePost with no user id" do
    imagepost = ImagePost.new  
    imagepost.title = "Sample Title"
    imagepost.content = "Sample Content"
    expect { imagepost.save! }.should raise_error
    ImagePost.count.should == 0
  end

  it "disallows a ImagePost with no content" do
    imagepost = ImagePost.new  
    imagepost.title = "Sample Title"
    imagepost.user_id = 1
    expect { imagepost.save! }.should raise_error
    ImagePost.count.should == 0
  end

  it "disallows a ImagePost with malformed link" do
    imagepost = ImagePost.new  
    imagepost.title = "Sample Title"
    imagepost.content = "Bad Image"
    imagepost.user_id = 1
    expect { imagepost.save! }.should raise_error
    ImagePost.count.should == 0
  end

  it "allows a ImagePost with content over 512 characters" do
    imagepost = ImagePost.new
    imagepost.title = "Sample Title"
    imagepost.content = "http://" + ("a" * 513) + ".com/example.png"
    imagepost.user_id = 1
    expect { imagepost.save! }.should_not raise_error
    ImagePost.count.should == 1
  end

  it "disallows a ImagePost with content over 2048 characters" do
    imagepost = ImagePost.new
    imagepost.title = "Sample Title"
    imagepost.content = "http://" + ("a" * 2026) + ".com/example.png"
    imagepost.user_id = 1
    expect { imagepost.save! }.should raise_error
    ImagePost.count.should == 0
  end
end