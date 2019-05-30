require_relative '../acceptance_helper'

feature 'Create answer' do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  scenario 'Only authorized user can answer', js: true do
    login(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'test answer'
    click_on 'Create'

    within '.answers' do
      expect(current_path).to eq question_path(question)
      expect(page).to have_content 'test answer'
    end
  end

  scenario 'Unauthorized user is trying to answer' do
    visit question_path(question)

    expect(page).to_not have_selector 'textarea'
  end

  scenario 'User try to create invalid answer', js: true do
    login(user)
    visit question_path(question)

    click_on 'Create'

    within '.answer-create > .errors' do
      expect(page).to have_content 'Body can\'t be blank'
    end
  end
end
