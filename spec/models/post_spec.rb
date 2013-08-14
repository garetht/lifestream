require 'spec_helper'

describe Post do

  it "has a valid factory" do
    expect(FactoryGirl.create(:post)).to be_valid
  end

  it "is invalid without a body" do
    expect(FactoryGirl.build(:post, body: nil)).to_not be_valid
  end

  it "can have no title" do
    expect(FactoryGirl.build(:post, title: nil)).to be_valid
  end

  it "accepts 'private' as a public_type" do
    expect(FactoryGirl.build(:post, public_type: "private")).to be_valid
  end

  it "does not accept 'bleah' as a public_type" do
    expect(FactoryGirl.build(:post, public_type: "bleah")).to_not be_valid
  end

  it "accepts 'markdown' as a content_type" do
    expect(FactoryGirl.build(:post, content_type: "markdown")).to be_valid
  end

  it "does not accept 'heroku' as a content_type" do
    expect(FactoryGirl.build(:post, content_type: "heroku")).to_not be_valid
  end

  it "returns its location for Google Maps" do
    post = FactoryGirl.create(:post)
    expect(post.gmaps4rails_address).to eql("756-770 Broadway, New York, NY 10003, USA")
  end

end