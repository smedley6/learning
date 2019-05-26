require 'rails_helper'

feature 'Create question' do
  given(:user) { create(:user) }

  scenario 'Only authorized user can ask question' do
    login(user)

    click_link 'Ask Question'
    fill_in 'Title', with: 'test title'
    fill_in 'Body', with: 'test body'
    click_on 'Create'

    expect(page).to have_content 'Question successfully created.'
    expect(page).to have_content 'test title'
  end

  scenario 'Unauthorized user is trying to ask a question' do
    visit new_question_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
