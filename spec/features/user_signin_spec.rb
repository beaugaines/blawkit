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
    expect(current_path).to eql dashboard_path
    expect(page).to have_content 'Welcome to your dashboard'
  end

end