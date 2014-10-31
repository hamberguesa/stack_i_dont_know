class QuestionsController < ApplicationController
  def index
    @questions = Question.order(votes: :desc)
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
  end

  def create
    @questions = Question.order(votes: :desc)
    @question = Question.new(question_params)
    respond_to do |request_format|
      if @question.save
        request_format.html { redirect_to @question }
        request_format.js   {}
      else
        request_format.html   { render 'index' }
        request_format.js   { render 'error.js.erb' }
      end
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def upvote
    @question = Question.find(params[:id])
    @question.increment!(:votes)
    
    respond_to do |request_format|
      request_format.html { redirect_to questions_path }
      request_format.js {}
    end    
  end
  
  def downvote
    @question = Question.find(params[:id])
    @question.decrement!(:votes)
    
    respond_to do |request_format|
      request_format.html { redirect_to questions_path }
      request_format.js {}
    end
  end
  
  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

end
