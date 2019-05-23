require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'post #create' do
    let(:question) { create(:question) }

    context 'valid attributes' do
      it 'a new question is saves in the database' do
        expect do
          post :create,
               params: {
                 question: attributes_for(:question)
               }
        end.to change(Question, :count).by(1)
      end
    end
    context 'invalid attributes' do
      it 'a new question is not saves in the database' do
        expect do
          post :create,
               params: {
                 question: attributes_for(:invalid_question)
               }
        end.to_not change(Question, :count)
      end
    end
  end
end
