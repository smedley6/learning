require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'post #create' do
    login_user

    context 'valid attributes' do
      it 'a new answer saves in the database' do
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
      it 'answer not saved in the database' do
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
