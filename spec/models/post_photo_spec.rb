require 'spec_helper'

describe PostPhoto do

  it "has a valid factory" do
    expect(FactoryGirl.create(:post_photo)).to be_valid
  end

  it "is invalid without an image" do
    expect(FactoryGirl.build(:post_photo, image: nil)).to_not be_valid
  end

  it "is invalid without a post_id" do
    expect(FactoryGirl.build(:post_photo, post_id: nil) ).to_not be_valid
  end

  it "is invalid without a numerical post_id" do
    expect(FactoryGirl.build(:post_photo, post_id: "strawberry")).to_not be_valid
  end

end