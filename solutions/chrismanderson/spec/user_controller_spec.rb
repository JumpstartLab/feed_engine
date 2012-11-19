require 'spec_helper'

describe UsersController do
  let(:user) {FactoryGirl.create(:user)}
  context "#new" do
    it "returns a new user" do
      UsersController.new.new.should be_a(User)
    end
  end

  context "#edit" do
    it "returns a user" do
      cont = UsersController.new
      cont.stub(:edit).and_return(User.find(user.id))
      cont.edit.should == user
    end
  end
end
