require 'spec_helper'

feature 'New Post' do
  before :each do
    visit "/users/sign_in"
    sign_in_as_testuser
    visit "/streams/1/posts/new"
  end

  it "should have a new post form" do
    page.should have_content "New Post"
  end



end