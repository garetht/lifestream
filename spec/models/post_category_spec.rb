require 'spec_helper'

describe PostCategory do

  it "has a valid factory" do
    expect(FactoryGirl.create(:post_category)).to be_valid
  end

  it "is invalid without a category_id" do
    expect(FactoryGirl.build(:post_category, category_id: nil)).to_not be_valid
  end

  it "is invalid without a post_id" do
    expect(FactoryGirl.build(:post_category, post_id: nil)).to_not be_valid
  end

  it "is invalid without a numerical category_id" do
    expect(FactoryGirl.build(:post_category, category_id: "strawberry")).to_not be_valid
  end

  it "is invalid without a numerical post_id" do
    expect(FactoryGirl.build(:post_category, post_id: "strawberry")).to_not be_valid
  end
  
end