FactoryBot.define do
  factory :question do
    title { 'test title' }
    body  { 'test body' }
    user
  end

  factory :invalid_question, class: 'Question' do
    title { nil }
    body  { nil }
  end
end
