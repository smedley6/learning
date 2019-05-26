require 'rails_helper'

feature 'Delete question' do
  given(:user) { create(:user) }
  given(:other) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Author can destroy own question' do
    login(user)
    visit question_path(question)

    within '.question' do
      click_link 'Delete'
    end

    expect(page).to have_content 'Question successfully deleted.'
    expect(current_path).to eq questions_path
  end

  scenario 'user cannot delete someone else\'s question' do
    login(other)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_content 'Delete'
    end
  end

  scenario 'unauthorized user cannot delete someone else\'s question' do
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_content 'Delete'
    end
  end
end
