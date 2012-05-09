require 'spec_helper'

describe "links/new" do
  before(:each) do
    assign(:link, stub_model(Link,
      :description => "MyText",
      :url => "MyString",
      :poster_id => 1
    ).as_new_record)
  end

  it "renders new link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => links_path, :method => "post" do
      assert_select "textarea#link_description", :name => "link[description]"
      assert_select "input#link_url", :name => "link[url]"
      assert_select "input#link_poster_id", :name => "link[poster_id]"
    end
  end
end
