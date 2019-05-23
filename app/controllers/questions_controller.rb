class QuestionsController < ApplicationController
  before_action :load_question, only: :show

  def show; end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)
    redirect_to @question if @question.save
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def load_question
    @question = Question.find(params[:id])
  end
end
