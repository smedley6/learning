require 'rails_helper'

feature 'Create answer' do
  given(:question) { create(:question) }

  scenario 'User can create answer' do
    visit question_path(question)

    fill_in 'Your answer', with: 'test answer'
    click_on 'Create'

    expect(page).to have_content 'test answer'
  end
end
