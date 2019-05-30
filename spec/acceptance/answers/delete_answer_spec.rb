require 'rails_helper'

feature 'Delete answer' do
  given(:user) { create(:user) }
  given(:other) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  scenario 'Author can destroy his answer', js: true do
    login(user)
    answer
    visit question_path(question)

    within '.answers' do
      click_link 'Delete'
      expect(page).to_not have_content answer.body
    end
  end
  scenario 'user cannot delete someone else\'s answer' do
    login(other)
    answer
    visit question_path(question)

    within '.answers' do
      expect(page).to have_content answer.body
      expect(page).to_not have_link 'Delete'
    end
  end
  scenario 'unauthorized user cannot delete someone else\'s answer' do
    answer
    visit question_path(question)

    within '.answers' do
      expect(page).to have_content answer.body
      expect(page).to_not have_link 'Delete'
    end
  end
end
