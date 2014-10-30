class AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    if @answer.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def upvote
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.upvote
    if @answer.save
      redirect_to "/questions/#{@question.id}"
    end
  end

  def downvote
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.downvote
    if @answer.save
      redirect_to "/questions/#{@question.id}"
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:title, :content)
  end

end
