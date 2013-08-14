require 'spec_helper'

describe Comment do

  it "has a valid factory" do
    expect(FactoryGirl.create(:comment)).to be_valid
  end

  it "is invalid without text" do
    expect(FactoryGirl.build(:comment, text: nil)).to_not be_valid
  end

  it "is invalid without a post_id" do
    expect(FactoryGirl.build(:comment, post_id: nil)).to_not be_valid
  end

  it "is invalid without a user_id" do
    expect(FactoryGirl.build(:comment, user_id: nil)).to_not be_valid
  end

  it "is invalid without a numerical post_id" do
    expect(FactoryGirl.build(:comment, post_id: "strawberry")).to_not be_valid
  end

  it "is invalid without a numerical user_id" do
    expect(FactoryGirl.build(:comment, user_id: "strawberry")).to_not be_valid
  end

  it "generates the correct children hash" do
    a = FactoryGirl.create(:comment, parent_id: nil, id: 1)
    b = FactoryGirl.create(:comment, parent_id: nil, id: 2)
    c = FactoryGirl.create(:comment, parent_id: nil, id: 3)
    d = FactoryGirl.create(:comment, parent_id: a.id, id: 4) 
    e = FactoryGirl.create(:comment, parent_id: a.id, id: 5) 
    f = FactoryGirl.create(:comment, parent_id: b.id, id: 6)
    g = FactoryGirl.create(:comment, parent_id: b.id, id: 7)
    h = FactoryGirl.create(:comment, parent_id: b.id, id: 8) 
    i = FactoryGirl.create(:comment, parent_id: h.id, id: 9)
    expect(Comment.children_hash(3)[nil]).to eql([a, b, c])
    expect(Comment.children_hash(3)[1]).to eql([d, e])
    expect(Comment.children_hash(3)[2]).to eql([f, g, h])
    expect(Comment.children_hash(3)[8]).to eql([i])
  end

end