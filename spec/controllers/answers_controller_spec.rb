require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe 'post #create' do
    login_user

    context 'valid attributes' do
      it 'a new answer saves in the database' do
        expect do
          post :create,
               params: {
                 question_id: question,
                 answer: attributes_for(:answer),
                 format: :js
               }
        end.to change(Answer, :count).by(1)
      end
    end
    context 'invalid attributes' do
      it 'answer not saved in the database' do
        expect do
          post :create,
               params: {
                 question_id: question,
                 answer: attributes_for(:invalid_answer),
                 format: :js
               }
        end.to_not change(question.answers, :count)
      end
    end
  end
  describe 'delete #destroy' do
    login_user
    before { @user.answers << answer }

    it 'delete answer' do
      expect do
        delete :destroy, params: { question_id: question, id: answer }
      end.to change(Answer, :count).by(-1)
    end
    it 'redirect to question' do
      delete :destroy, params: { question_id: question, id: answer }
      expect(response).to redirect_to question_path(question)
    end
  end
end
