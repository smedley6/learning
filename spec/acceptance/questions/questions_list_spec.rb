require 'rails_helper'

feature 'Questions list' do
  given(:question) { create(:question) }

  scenario 'User can view a list of questions' do
    question
    visit questions_path

    expect(page).to have_link question.title
  end
end
