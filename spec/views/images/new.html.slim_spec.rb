require 'spec_helper'

describe "images/new" do
  before(:each) do
    assign(:image, stub_model(Image,
      :description => "MyText",
      :url => "MyString",
      :poster_id => 1
    ).as_new_record)
  end

  it "renders new image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => images_path, :method => "post" do
      assert_select "textarea#image_description", :name => "image[description]"
      assert_select "input#image_url", :name => "image[url]"
      assert_select "input#image_poster_id", :name => "image[poster_id]"
    end
  end
end
