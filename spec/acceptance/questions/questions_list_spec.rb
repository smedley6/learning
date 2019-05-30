require_relative '../acceptance_helper'

feature 'Questions list' do
  given(:question) { create(:question) }

  it 'User can see a list of questions' do
    question
    visit questions_path

    expect(page).to have_link question.title
  end
end
