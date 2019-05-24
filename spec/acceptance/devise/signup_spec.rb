require 'rails_helper'

feature 'Sign up' do
  scenario 'New user can register' do
    visit new_user_registration_path

    fill_in 'Email', with: 'user1@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
