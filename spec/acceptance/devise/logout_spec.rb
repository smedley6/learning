require 'rails_helper'

feature 'User can logout' do
  given(:user) { create(:user) }

  scenario 'Authorized user can logout' do
    login(user)

    click_link 'logout'

    expect(page).to have_content 'Signed out successfully.'
  end
end
