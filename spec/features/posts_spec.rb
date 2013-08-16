require 'spec_helper'

feature 'New Post' do
  before :each do
    visit "/users/sign_in"
    sign_in_as_testuser
    save_and_open_page
    click_button "Create a New Post"
  end

  it "should have a new post form" do
    page.should have_content "new post"
  end

end