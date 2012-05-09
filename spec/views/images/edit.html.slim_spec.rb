require 'spec_helper'

describe "images/edit" do
  before(:each) do
    @image = assign(:image, stub_model(Image,
      :description => "MyText",
      :url => "MyString",
      :poster_id => 1
    ))
  end

  it "renders the edit image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => images_path(@image), :method => "post" do
      assert_select "textarea#image_description", :name => "image[description]"
      assert_select "input#image_url", :name => "image[url]"
      assert_select "input#image_poster_id", :name => "image[poster_id]"
    end
  end
end
