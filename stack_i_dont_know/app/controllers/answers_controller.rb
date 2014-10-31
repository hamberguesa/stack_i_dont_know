class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    respond_to do |request_format|
      if @answer.save
        request_format.html { redirect_to @question }
        request_format.js {}
      else
        request_format.html { render 'questions/show' }
        request_format.js { render 'error.js.erb' }
      end
    end
  end

  def upvote
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.increment!(:votes)

    respond_to do |request_format|
      request_format.html { redirect_to @question }
      request_format.js {}
    end
  end

  def downvote
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.decrement!(:votes)

    respond_to do |request_format|
      request_format.html { redirect_to @question }
      request_format.js {}
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :content)
  end

end
