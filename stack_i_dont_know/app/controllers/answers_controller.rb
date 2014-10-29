class AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    @answer.save

    redirect_to @question
  end

  private
  def answer_params
    params.require(:answer).permit(:title, :content)
  end

end
