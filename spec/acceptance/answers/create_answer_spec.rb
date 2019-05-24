require 'rails_helper'

feature 'Create answer' do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  scenario 'Only authorized user can answer' do
    login(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'test answer'
    click_on 'Create'

    within '.answers' do
      expect(page).to have_content 'test answer'
    end
  end

  scenario 'Unauthorized user is trying to answer' do
    visit question_path(question)

    expect(page).to_not have_selector 'textarea'
  end
end
