require 'rails_helper'

feature 'Edit question' do
  let(:user) { create(:user) }
  let(:other) { create(:user) }
  let(:question) { create(:question) }

  scenario 'Author can see edit form', js: true do
    login(user)
    user.questions << question
    visit question_path(question)

    within '.question' do
      click_link 'Edit'
      expect(page).to have_selector '.edit_question'
    end
  end

  scenario 'error output', js: true do
    login(user)
    user.questions << question
    visit question_path(question)

    within '.question' do
      click_link 'Edit'
      fill_in 'Title', with: ''
      click_on 'Update'

      expect(page).to have_content 'Title can\'t be blank'
    end
  end

  scenario 'Author can update his question', js: true do
    login(user)
    user.questions << question
    visit question_path(question)

    within '.question' do
      click_link 'Edit'
      fill_in 'Title', with: 'Edited question'
      fill_in 'Body', with: 'Edited body'
      click_on 'Update'
    end

    within '.question > h1' do
      expect(page).to have_content 'Edited question'
    end
    within '.question > .body' do
      expect(page).to have_content 'Edited body'
    end
  end

  scenario 'User can not edit someone else\'s question' do
    login(other)
    user.questions << question
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Edit'
    end
  end

  scenario 'Unauthorized user can not see an edit link' do
    user.questions << question
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Edit'
    end
  end
end
