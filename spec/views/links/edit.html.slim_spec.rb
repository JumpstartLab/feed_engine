require 'spec_helper'

describe "links/edit" do
  before(:each) do
    @link = assign(:link, stub_model(Link,
      :description => "MyText",
      :url => "MyString",
      :poster_id => 1
    ))
  end

  it "renders the edit link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => links_path(@link), :method => "post" do
      assert_select "textarea#link_description", :name => "link[description]"
      assert_select "input#link_url", :name => "link[url]"
      assert_select "input#link_poster_id", :name => "link[poster_id]"
    end
  end
end
