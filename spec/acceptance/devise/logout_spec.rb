require_relative '../acceptance_helper'

feature 'Log out' do
  given(:user) { create(:user) }

  scenario 'Authorized user can logout' do
    login(user)

    click_link 'logout'

    expect(page).to have_content 'Signed out successfully.'
  end
end
