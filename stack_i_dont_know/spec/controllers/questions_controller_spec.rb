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

    it "routes /questions to questions#index" do
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

    it "routes /questions/:id to questions#show" do
      expect(get: "/questions/#{@question.id}").to route_to(
        controller: "questions",
        action: "show",
        id: "#{@question.id}"
        )
    end
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

    it "routes /questions/new to questions#new" do
      expect(get: "/questions/new").to route_to(
        controller: "questions",
        action: "new"
        )
    end
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
   it "edit is successful" do
      get :edit, id: @question.id
      expect(response.status).to eq 200
    end

    it "renders the new template" do
      get :edit, id: @question.id
      expect(response).to render_template :edit, id: @question.id
    end

    it "routes /questions/:id/edit to questions#edit" do
      expect(get: "/questions/#{@question.id}/edit").to route_to(
        controller: "questions",
        action: "edit", 
        id: "#{@question.id}"
        )
    end
  end

  context "UPDATE" do
    let(:no_title_question){ patch :update, id: @question, question: {title: "", content: @question.content} }
    let(:question){ patch :update, id: @question, question: {title: "Hello", content: "This is a test"} }
    
    it "redirects to question#show if update is successful" do
      expect(question).to redirect_to :action => :show,
                                      :id => assigns(:question).id
    end

    it "renders the edit screen if the update doesn't save" do
      expect(no_title_question).to render_template :edit
    end

    it "update is successful" do 
      expect(response).to be_success
    end

    it "locates the requested question" do
      patch :update, id: @question, question: {title: @question.title, content: @question.content}
      expect(assigns(:question)).to eq(@question)
    end

    it "updates the request" do
      patch :update, id: @question, question: {title:"Hello", content: @question.content}
      @question.reload
      expect(@question.title).to eq("Hello")
    end
  end

  context "DESTROY" do
    it "deletes the question" do
      expect{ 
        delete :destroy, :id => @question.id
      }.to change(Question, :count).by(-1)
    end
  end

  after(:each) do
    @question = nil
    @answer = nil
  end
end
