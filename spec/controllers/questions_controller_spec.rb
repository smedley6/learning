require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'get #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates @questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'get #show' do
    before { get :show, params: { id: question } }

    it 'populates @question' do
      expect(assigns(:question)).to eq question
    end
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'get #new' do
    before { get :new }

    it 'populates @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'post #create' do
    context 'valid attributes' do
      it 'a new question is saves in the database' do
        expect do
          post :create,
               params: {
                 question: attributes_for(:question)
               }
        end.to change(Question, :count).by(1)
      end
      it 'redirect to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
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
      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end
end
