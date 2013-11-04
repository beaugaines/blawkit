require 'spec_helper'

feature 'User signup', %q{
  As a prospective user
  I want to be able to visit the home page
  And sign up
  So I can use the site
} do


  scenario 'successful sign up'  do
    visit root_path
    click_link 'Sign up'
    fill_in 'Email', with: 'user@guy.com'
    fill_in 'Password', with: 'shhhhhh'
    fill_in 'Password confirmation', with: 'shhhhhh'
    puts page.html
    click_button 'Sign up'
    expect(page).to have_content('You have signed up successfully.')
  end

  scenario 'unsuccessful sign up' do
  end
end