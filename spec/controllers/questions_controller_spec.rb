require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }

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
    let(:question) { create(:question) }
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
      scenario 'a new question saves in the database' do
        expect do
          post :create, params: { question: attributes_for(:question) }
        end.to change(Question, :count).by(1)
      end
      scenario 'redirect to question' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    context 'invalid attributes' do
      scenario 'question not saved in the database' do
        expect do
          post :create, params: { question: attributes_for(:invalid_question) }
        end.to_not change(Question, :count)
      end
    end
  end
end
