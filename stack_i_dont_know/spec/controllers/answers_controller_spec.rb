require 'rails_helper'
require 'spec_helper'

describe QuestionsController do
  before(:each) do
    @question = Question.create(:title => "What is AJAX?", :content => "AJAX for what?")
    @answer = @question.answers.create(:title => "AJAX is awesome", :content => "Asynchronous JavaScript and XML")
  end

  context "NEW" do
    it "new is successful" do
      get :new
      expect(response.status).to eq 200
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end

    it "routes /questions/:question_id/answers/new to answers#new" do
      expect(get: "questions/#{@question.id}/answers/new").to route_to(
        controller: "answers",
        action: "new",
        question_id: "#{@question.id}"
        )
    end
  end

  context "CREATE" do
    let(:answer){ post :create, question: {title: "This is an answer title", content: "This is an answer's content."}}
    let(:no_title_answer){ post :create, question: {content: "this is an answer content"} }

    it "redirects to question if create is successful" do
      expect(answer).to redirect_to :action => :show,
                                    :id => assigns(:question).id
    end

    it "re-renders new form if title is not provided" do
      expect(no_title_answer).to render_template :new
    end

    it "does not create an answer in the DB if title is not provided" do
      no_title_params = {content: "this is an answer content"}
      expect { Answer.create(no_title_params) }.to_not change(Answer, :count)
    end

    it "re-renders new form if content is not provided" do
      expect(no_title_answer).to render_template :new
    end

    it "does not create an answer in the DB if content is not provided" do
      no_content_params = {title: "This is an answer title"}
      expect { Answer.create(no_content_params) }.to_not change(Answer, :count)
    end

  end

  after(:each) do
    @question = nil
    @answer = nil
  end
end