class AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question }
        format.js {}
      else
        format.html { render 'new' }
        format.js {}
      end
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
