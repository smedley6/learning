require 'rails_helper'

feature 'Create question' do
  scenario 'User can create question' do
    visit new_question_path
    fill_in 'Title', with: 'Test title'
    fill_in 'Body', with: 'Test body'
    click_on 'Create'

    expect(page).to have_content 'Test title'
    expect(page).to have_content 'Test body'
  end
end
