module UserHelper

  def login user
    visit new_user_session_path
    fill_in 'Email', with: user.email, match: :prefer_exact
    fill_in 'Password', with: user.password , match: :prefer_exact
    click_button 'Sign in'
  end

  def logout
    click_link 'Sign out'
  end
  
end
