require 'rails_helper'

feature 'User can login' do
  given(:user) { create(:user) }

  scenario 'A registered user is trying to login' do
    login(user)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed in successfully.'
  end
end
