class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :destroy, :edit, :update, :upvote, :downvote]

  def find_question
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.all
  end

  def show
    # @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def destroy
    # @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end

  def edit
    # @question = Question.find(params[:id])
  end

  def update
    # @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def upvote
    @question.upvote
    if @question.save
      redirect_to @question
    else
      render 'show'
    end
  end

  def downvote
    @question.downvote
    if @question.save
      redirect_to @question
    else
      render 'show'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

end
