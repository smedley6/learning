class AnswersController < ApplicationController
  before_action :load_question

  def create
    @answer = @question.answers.create(answer_params)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
