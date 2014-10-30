require 'rails_helper'
require 'spec_helper'

describe QuestionsController do
  before(:each) do
    @question = Question.create(:title => "What is AJAX?", :content => "AJAX for what?")
    @answer = @question.answers.create(:title => "AJAX is awesome", :content => "Asynchronous JavaScript and XML")
  end
  context "INDEX" do
    it 'index is successful' do
      get :index
      expect(response.status).to eq 200
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end

    it "routes /questions to messages#index" do
      expect(get: "/questions").to route_to(
        controller: "questions",
        action: "index"
        )
    end
  end

  context "SHOW" do
    it 'show is successful' do
      get :show, id: @question.id
      expect(response.status).to eq 200
    end

    it "renders the show template" do
      get :show, id: @question.id
      expect(response).to render_template :show, id: @question.id
    end

    it "routes /questions/:id to messages#show" do
      expect(get: "/questions/#{@question.id}").to route_to(
        controller: "questions",
        action: "show",
        id: "#{@question.id}"
        )
    end
  end

  context "NEW" do

  end

  context "CREATE" do
    let(:question){ post :create, question: {title: "what's up dog?", content: "how's it going?"} }
    let(:no_title_question){ post :create, question: {content: "hi"} }
    it "create is successful" do
      expect(question).to redirect_to :action => :show,
                                      :id => assigns(:question).id
    end

    it "does not create if title is not provided" do
      expect(no_title_question).to render_template :new
    end

    it "does not create a question in the DB if title is not provided" do
      no_title_params = {:content => "hi"}
      expect{ Question.create(no_title_params) }.to_not change(Question, :count)
    end
  end

  context "EDIT" do

  end

  context "UPDATE" do

  end

  context "DESTROY" do

  end

  after(:each) do
    @question = nil
    @answer = nil
  end
end
