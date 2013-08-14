require 'spec_helper'

describe Friendship do

  it "has a valid factory" do
    expect(FactoryGirl.create(:friendship)).to be_valid
  end

  it "is invalid without a friend_id" do
    expect(FactoryGirl.build(:friendship, friend_id: nil)).to_not be_valid
  end

  it "is invalid without a user_id" do
    expect(FactoryGirl.build(:friendship, user_id: nil)).to_not be_valid
  end

  it "is invalid without a numerical friend_id" do
    expect(FactoryGirl.build(:friendship, friend_id: "strawberry")).to_not be_valid
  end

  it "is invalid without a numerical user_id" do
    expect(FactoryGirl.build(:friendship, user_id: "strawberry")).to_not be_valid
  end

  it "can create a friendship that is 'pending'" do
    expect(FactoryGirl.build(:friendship, friend_status: "pending")).to be_valid
  end

  it "can create a friendship that is 'requested'" do
    expect(FactoryGirl.build(:friendship, friend_status: "requested")).to be_valid
  end

  it "will not create a friendship that is 'bleen'" do
    expect(FactoryGirl.build(:friendship, friend_status: "bleen")).to_not be_valid
  end

end