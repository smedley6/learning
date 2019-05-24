require 'rails_helper'

feature 'User can sign in' do
  given(:user) { create(:user) }

  scenario 'A registered user is trying to login' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed in successfully.'
  end
end
