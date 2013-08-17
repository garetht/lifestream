require 'spec_helper'

feature 'New Post', js: true do
  before :each do
    visit "/users/sign_in"
    sign_in_as_testuser
    visit "/streams/1/posts/new"
  end

  it "has a new post form" do
    expect(page).to have_content "NEW POST"
  end

  it "can create a basic post with just a body" do
    fill_in "edit-title", with: "Test Title"
    fill_in "markdown-edit", with: "Test Content"
    fill_in "edit-location", with: "770 Broadway, New York, NY 10003, USA"
    
  end

  it "raises an error when the body is empty" do
    
  end

  it "can attach images to a post" do
    
  end

end