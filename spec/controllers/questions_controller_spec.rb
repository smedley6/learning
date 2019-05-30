require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'get #index' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'assigns @questions' do
      expect(assigns(:questions)).to eq questions
    end
    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'get #show' do
    before { get :show, params: { id: question } }

    it 'assigns @question' do
      expect(assigns(:question)).to eq question
    end
    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'get #new' do
    login_user
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'post #create' do
    login_user

    context 'valid attributes' do
      it 'a new question saves in the database' do
        expect do
          post :create, params: { question: attributes_for(:question) }
        end.to change(Question, :count).by(1)
      end
      it 'redirect to question' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    context 'invalid attributes' do
      it 'question not saved in the database' do
        expect do
          post :create, params: { question: attributes_for(:invalid_question) }
        end.to_not change(Question, :count)
      end
    end
  end

  describe 'patch #update' do
    login_user
    before { @user.questions << question }

    it 'question update' do
      patch :update, params: {
        id: question,
        question: { title: 'edited title', body: 'edited body' },
        format: :js
      }

      question.reload
      expect(question.title).to eq 'edited title'
      expect(question.body).to eq 'edited body'
    end
  end

  describe 'delete #destroy' do
    login_user
    before { @user.questions << question }

    it 'question deleted' do
      expect do
        delete :destroy, params: { id: question }
      end.to change(Question, :count).by(-1)
    end

    it 'redirect to questions' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
