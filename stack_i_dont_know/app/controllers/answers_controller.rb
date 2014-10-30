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
    @answer = Answer.find(params[:id])
    @answer.increment!(:votes)
    
    redirect_to @question
  end
  
  def downvote
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.decrement!(:votes)
    
    redirect_to @question
  end

  private
  
  def answer_params
    params.require(:answer).permit(:title, :content)
  end

end
