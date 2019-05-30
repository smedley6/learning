require 'rails_helper'

feature 'Edit question' do
  given(:user) { create(:user) }
  given(:other) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, user: user) }

  scenario 'the author sees the edit form' do
    login(user)
    question.answers << answer
    visit question_path(question)

    within '.answers' do
      expect(page).to have_selector 'textarea'
    end
  end

  scenario 'error output', js: true do
    login(user)
    question.answers << answer
    visit question_path(question)

    within '.answers' do
      click_link 'Edit'
      fill_in 'Your answer', with: ''
      click_on 'Update'
    end

    within '.errors' do
      expect(page).to have_content 'Body can\'t be blank'
    end
  end

  scenario 'the author can edit his answer', js: true do
    login(user)
    question.answers << answer
    visit question_path(question)

    within '.answers' do
      click_link 'Edit'
      fill_in 'Your answer', with: 'Edited answer'
      click_on 'Update'
      expect(page).to have_content 'Edited answer'
    end
  end

  scenario 'User can not edit someone else\'s answer' do
    login(other)
    question.answers << answer
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_content 'Edit'
    end
  end

  scenario 'Unauthorized user can not see an edit link' do
    question.answers << answer
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Edit'
    end
  end
end
