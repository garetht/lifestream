require 'spec_helper'

describe Stream do

  it "has a valid factory" do
    expect(FactoryGirl.create(:stream)).to be_valid
  end

  it "is invalid without a user_id" do
    expect(FactoryGirl.build(:stream, user_id: nil)).to_not be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:stream, name: nil)).to_not be_valid
  end

  it "is invalid without a numerical user_id" do
    expect(FactoryGirl.build(:stream, user_id: "strawberry")).to_not be_valid
  end

end