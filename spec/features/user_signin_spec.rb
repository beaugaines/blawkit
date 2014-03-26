require 'spec_helper'

feature 'User signin', %q{
  As a user
  I want to be able to sign in
  On the homepage
  And be redirected to my dashboard
  So I can access my content
} do

  before do
    @user = create(:user)
  end

  scenario 'signin and redirect to dashboard' do
    login(@user)
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: @user.email, match: :prefer_exact
    fill_in 'Password', with: @user.password, match: :prefer_exact
    click_button 'Sign in'
    expect(current_path).to eql authenticated_root_path
    expect(page).to have_content 'Welcome to your dashboard'
  end

end