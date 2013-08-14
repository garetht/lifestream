require 'spec_helper'

feature 'Sign Up' do
  before :each do
    visit "/users/sign_up"
  end

  it "has a user sign up page" do
    page.should have_content "Sign up for a free account with Lifestream."
  end

  it "takes a username, email, password, and password confirmation" do
    page.should have_content "Username"
    page.should have_content "Email"
    page.should have_content "Password"
    page.should have_content "Password confirmation"
  end

  it "validates the presence of the fields" do
    fill_in "user_username", with: 'testuser'
    click_button 'Sign up'
    page.should have_content "Sign up for a free account with Lifestream."
  end

  it "notifies the user of duplicates" do
    fill_in "user_username", with: "testuser"
    fill_in "user_email", with: "testing@test.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"
    page.should have_content "Username has already been taken"
  end
end

feature 'Sign In' do
  before :each do
    visit "/users/sign_in"
  end

  it "signs in an existing user" do
    sign_in_as_testuser
    page.should have_content "Success"
  end
end