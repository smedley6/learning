require_relative '../acceptance_helper'

feature 'Accept answer' do
  given(:user) { create :user }
  given(:answers) { create_list(:answer, 2) }
  given(:question) { create(:question, user: user) }

  scenario 'questioner may choose the best answer', js: true do
    login(user)
    answers.each do |answer|
      question.answers << answer
    end
    visit question_path(question)

    id = question.answers.last.id
    page.find("a.accept-#{id}").click

    within '.answer:first-child' do
      expect(page).to have_content 'Best answer'
      expect(page).to have_link 'Accepted'
    end
  end
end
