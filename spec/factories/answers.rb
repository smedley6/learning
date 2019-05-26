FactoryBot.define do
  factory :answer do
    body { 'test answer' }
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body { nil }
  end
end
