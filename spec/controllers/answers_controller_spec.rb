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
  describe 'patch #update' do
    login_user
    before { @user.answers << answer }

    it 'update answer' do
      patch :update,
            params: {
              question_id: question,
              id: answer,
              answer: { body: 'edited answer' },
              format: :js
            }
      answer.reload
      expect(answer.body).to eq 'edited answer'
    end
  end
  describe 'delete #destroy' do
    login_user
    before { @user.answers << answer }

    it 'delete answer' do
      expect do
        delete :destroy,
               params: {
                 question_id: question,
                 id: answer,
                 format: :js
               }
      end.to change(Answer, :count).by(-1)
    end
  end

  describe 'put #accept' do
    login_user
    before { @user.questions << question }

    it 'accepted answer' do
      put :accept,
          params: {
            question_id: question.id,
            id: answer,
            format: :js
          }
      answer.reload
      expect(answer.accepted).to eq true
    end
  end
end
