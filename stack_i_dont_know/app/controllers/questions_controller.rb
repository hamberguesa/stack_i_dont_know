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
    if @question.save
      redirect_to @question
    else
      render 'index'
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
    
    redirect_to questions_path
  end
  
  def downvote
    @question = Question.find(params[:id])
    @question.decrement!(:votes)
    
    redirect_to questions_path
  end
  
  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

end
