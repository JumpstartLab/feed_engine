require 'spec_helper'

describe "Regrowl" do
  let(:user1) { FactoryGirl.create(:user_with_growls)}
  let(:user2) { FactoryGirl.create(:user_with_growls)}
  let(:user3) { FactoryGirl.create(:user_with_growls)}

  it "Can Regrowl" do
    user1.growls.find(1).build_regrowl_for(user2).save.should be_true
  end

  it "Cannot regrowl any growls which you originally posted" do
    regrowl = user1.growls.find(1).build_regrowl_for(user2)
    regrowl.save.should be_true
    regrowl.build_regrowl_for(user1).should == nil
  end

  it "Regrowl gives credit to owner" do
    user1.growls.find(1).build_regrowl_for(user2).save
    regrowl = user2.growls.find_by_regrowled_from_id(1).build_regrowl_for(user3)
    regrowl.regrowled_from_id.should == 1
  end
end