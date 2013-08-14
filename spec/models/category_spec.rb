require 'spec_helper'

describe Category do

  it "has a valid factory" do
    expect(FactoryGirl.create(:category)).to be_valid
  end

  it "is invalid without a user_id" do
    expect(FactoryGirl.build(:category, user_id: nil)).to_not be_valid
  end

  it "is invalid without a numerical user_id" do
    expect(FactoryGirl.build(:category, user_id: "strawberry")).to_not be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:category, name: nil)).to_not be_valid
  end

  describe "Calculation of Tree Structure" do
    before :each do
      a = FactoryGirl.create(:category, parent_id: nil, id: 1)
      b = FactoryGirl.create(:category, parent_id: nil, id: 2)
      c = FactoryGirl.create(:category, parent_id: nil, id: 3)
      d = FactoryGirl.create(:category, parent_id: a.id, id: 4) 
      e = FactoryGirl.create(:category, parent_id: a.id, id: 5) 
      f = FactoryGirl.create(:category, parent_id: b.id, id: 6)
      g = FactoryGirl.create(:category, parent_id: b.id, id: 7)
      h = FactoryGirl.create(:category, parent_id: b.id, id: 8) 
      i = FactoryGirl.create(:category, parent_id: h.id, id: 9)
    end

    it "can determine the path from itself back to the root, returning
    category objects along the way" do
      expect(Category.find(9).trace_full_path).to eql([Category.find(9), Category.find(8), Category.find(2)])
    end

    it "can determine the path from itself back to the root, 
    returning category ids along the way" do
      expect(Category.find(9).trace_id_path).to eql([9, 8, 2])
    end

    it "can determine its children hash" do
      expect(Category.children_hash(1)[nil]).to eql([Category.find(1), Category.find(2), Category.find(3)])
      expect(Category.children_hash(1)[1]).to eql([Category.find(4), Category.find(5)])
      expect(Category.children_hash(1)[2]).to eql([Category.find(6), Category.find(7), Category.find(8)])
      expect(Category.children_hash(1)[8]).to eql([Category.find(9)])
    end

  end

end