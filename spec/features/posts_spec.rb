require 'spec_helper'

feature 'New Post', js: true do
  before :each do
    visit "/users/sign_in"
    sign_in_as_testuser
    visit "/streams/1/posts/new"
  end

  it "should have a new post form" do
    expect(page).to have_content "NEW POST"
  end



end