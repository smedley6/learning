FactoryBot.define do
  factory :answer do
    body { 'test answer' }
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body { nil }
  end
end
