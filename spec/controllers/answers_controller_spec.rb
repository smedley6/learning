require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'post #create' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }

    context 'valid attributes' do
      it 'a new answer is saves in the database' do
        expect do
          post :create,
               params: {
                 question_id: question,
                 answer: attributes_for(:answer)
               }
        end.to change(Answer, :count).by(1)
      end
    end

    context 'invalid attributes' do
      it 'a new answer is not saves in the database' do
        expect do
          post :create,
               params: {
                 question_id: question,
                 answer: attributes_for(:invalid_answer)
               }
        end.to_not change(Answer, :count)
      end
    end
  end
end
