require 'httparty'
class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :destroy, :edit, :update, :upvote, :downvote]

  before_action :question_blank, only: [:new, :index]

  def question_blank
    @question = Question.new
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.all
    # @question = Question.new

    hello = ENV['HELLO']
    password = ENV['PASSWORD']

    @response = HTTParty.get('https://api.github.com/zen', :basic_auth => {:username => hello, :password => password}, :headers => {"User-Agent" => hello})
  end

  def show
    # @question = Question.find(params[:id])
  end

  def new
    # @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        format.html {redirect_to @question}
        format.js {}
      else
        render 'new'
      end
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
